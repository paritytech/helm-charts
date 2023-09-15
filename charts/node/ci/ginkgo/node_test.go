package node_test

import (
	"context"
	"time"

	// utils "github.com/bitnami/charts/.vib/common-tests/ginkgo-utils"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
	appsv1 "k8s.io/api/apps/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

const (
	PollingInterval = 1 * time.Second
)

var _ = Describe("Node", Ordered, func() {
	var c *kubernetes.Clientset
	var ctx context.Context
	var cancel context.CancelFunc

	BeforeEach(func() {

		ctx, cancel = context.WithCancel(context.Background())
		config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
		if err != nil {
			panic(err.Error())
		}
		// conf := utils.MustBuildClusterConfig(kubeconfig)
		c = kubernetes.NewForConfigOrDie(config)
	})

	When("a node is running", func() {
		It("should post a healthy status", func() {

			getAvailableReplicas := func(ss *appsv1.StatefulSet) int32 { return ss.Status.AvailableReplicas }
			getOpts := metav1.GetOptions{}

			stsName := releaseName
			By("checking all the replicas are available")
			ss, err := c.AppsV1().StatefulSets(namespace).Get(ctx, stsName, getOpts)
			Expect(err).NotTo(HaveOccurred())
			Expect(ss.Status.Replicas).NotTo(BeZero())
			origReplicas := *ss.Spec.Replicas

			Eventually(func() (*appsv1.StatefulSet, error) {
				return c.AppsV1().StatefulSets(namespace).Get(ctx, stsName, getOpts)
			}, timeout, PollingInterval).Should(WithTransform(getAvailableReplicas, Equal(origReplicas)))

			// svc, err := c.CoreV1().Services(namespace).Get(ctx, releaseName, getOpts)
			// Expect(err).NotTo(HaveOccurred())

			// port, err := utils.SvcGetPortByName(svc, "tcp-client")
			// Expect(err).NotTo(HaveOccurred())

			// image, err := utils.StsGetContainerImageByName(ss, "kafka")
			// Expect(err).NotTo(HaveOccurred())

			// jobSuffix := time.Now().Format("20060102150405")

			// By("creating a job to create a new test topic")
			// createTPJobName := fmt.Sprintf("%s-createtp-%s",
			// 	stsName, jobSuffix)
			// tpName := fmt.Sprintf("test%s", jobSuffix)

			// err = createJob(ctx, c, createTPJobName, port, image, "--create", tpName)
			// Expect(err).NotTo(HaveOccurred())

			// Eventually(func() (*batchv1.Job, error) {
			// 	return c.BatchV1().Jobs(namespace).Get(ctx, createTPJobName, getOpts)
			// }, timeout, PollingInterval).Should(WithTransform(getSucceededJobs, Equal(int32(1))))

			// By("scaling down to 0 replicas")
			// ss, err = utils.StsScale(
			// 	ctx, c, ss, 0)
			// Expect(err).NotTo(HaveOccurred())

			// Eventually(func() (*appsv1.StatefulSet, error) {
			// 	return c.AppsV1().StatefulSets(namespace).Get(ctx, stsName, getOpts)
			// }, timeout, PollingInterval).Should(WithTransform(getAvailableReplicas, BeZero()))

			// By("scaling up to the original replicas")
			// ss, err = utils.StsScale(
			// 	ctx, c, ss, origReplicas)
			// Expect(err).NotTo(HaveOccurred())

			// Eventually(func() (*appsv1.StatefulSet, error) {
			// 	return c.AppsV1().StatefulSets(namespace).Get(ctx, stsName, getOpts)
			// }, timeout, PollingInterval).Should(WithTransform(getAvailableReplicas, Equal(origReplicas)))

			// By("creating a job to drop the test topic")
			// deleteTPJobName := fmt.Sprintf("%s-deletetp-%s",
			// 	stsName, jobSuffix)
			// err = createJob(ctx, c, deleteTPJobName, port, image, "--delete", tpName)
			// Expect(err).NotTo(HaveOccurred())

			// Eventually(func() (*batchv1.Job, error) {
			// 	return c.BatchV1().Jobs(namespace).Get(ctx, deleteTPJobName, getOpts)
			// }, timeout, PollingInterval).Should(WithTransform(getSucceededJobs, Equal(int32(1))))
		})
	})

	AfterEach(func() {
		cancel()
	})
})
