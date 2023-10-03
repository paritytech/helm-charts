package node_test

import (
	"context"
	"fmt"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
	appsv1 "k8s.io/api/apps/v1"
	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

var _ = Describe("tick-collator", Ordered, func() {
	var c *kubernetes.Clientset
	var ctx context.Context
	var cancel context.CancelFunc
	const releaseName = "tick-collator"

	BeforeEach(func() {

		ctx, cancel = context.WithCancel(context.Background())
		config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
		if err != nil {
			panic(err.Error())
		}
		c = kubernetes.NewForConfigOrDie(config)
	})

	When("a collator node's (tick) chain data is being restored from the backup", func() {
		It("download-chain-snapshot init-container should exit with 0 code", func() {
			getAvailableReplicas := func(ss *appsv1.StatefulSet) int32 { return ss.Status.AvailableReplicas }
			getOpts := metav1.GetOptions{}

			stsName := fmt.Sprintf("%s-node", releaseName)

			By("checking all the replicas are available")
			ss, err := c.AppsV1().StatefulSets(namespace).Get(ctx, stsName, getOpts)
			Expect(err).NotTo(HaveOccurred())
			Expect(ss.Status.Replicas).NotTo(BeZero())
			origReplicas := *ss.Spec.Replicas
			Eventually(func() (*appsv1.StatefulSet, error) {
				return c.AppsV1().StatefulSets(namespace).Get(ctx, stsName, getOpts)
			}, timeout, PollingInterval).Should(WithTransform(getAvailableReplicas, Equal(origReplicas)))

			By("checking init-container status")
			Eventually(func() (*v1.PodList, error) {
				return c.CoreV1().Pods(namespace).List(ctx, metav1.ListOptions{
					LabelSelector: fmt.Sprintf("app.kubernetes.io/instance=%s", releaseName),
				})
			}, timeout, PollingInterval).Should(WithTransform(func(pods *v1.PodList) bool {
				for _, pod := range pods.Items {
					podInitContainerStatuses := pod.Status.InitContainerStatuses
					podInitContainersNames := []string{}
					for _, podInitContainerStatus := range podInitContainerStatuses {
						podInitContainersNames = append(podInitContainersNames, podInitContainerStatus.Name)
					}
					Expect(podInitContainersNames).To(ContainElement("download-chain-snapshot"))
					for _, podInitContainerStatus := range podInitContainerStatuses {
						if podInitContainerStatus.Name == "download-chain-snapshot" {
							return podInitContainerStatus.State.Terminated.ExitCode == 0
						}
					}
				}
				return false
			}, BeTrue()))
		})
	})

	AfterEach(func() {
		cancel()
	})
})
