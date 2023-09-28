package node_test

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
	appsv1 "k8s.io/api/apps/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

var _ = Describe("dev-rpc", Ordered, func() {
	var c *kubernetes.Clientset
	var ctx context.Context
	var cancel context.CancelFunc
	const releaseName = "dev-rpc"

	BeforeEach(func() {

		ctx, cancel = context.WithCancel(context.Background())
		config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
		if err != nil {
			panic(err.Error())
		}
		c = kubernetes.NewForConfigOrDie(config)
	})

	When("an RPC node is running", func() {
		It("should return the list of supported RPC methods", func() {

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

			rpcIngress, err := c.NetworkingV1().Ingresses(namespace).Get(ctx, stsName, getOpts)
			Expect(err).NotTo(HaveOccurred())

			loadbalancerIP := rpcIngress.Status.LoadBalancer.Ingress[0].IP
			rpcHostname := rpcIngress.Spec.Rules[0].Host

			reqJSON := []byte(`{"id":42, "jsonrpc":"2.0", "method": "rpc_methods"}`)
			req, err := http.NewRequest("POST", fmt.Sprintf("http://%s", loadbalancerIP), bytes.NewBuffer(reqJSON))
			Expect(err).NotTo(HaveOccurred())
			req.Host = rpcHostname
			req.Header.Set("Content-Type", "application/json")
			resp, err := http.DefaultClient.Do(req)
			Expect(err).NotTo(HaveOccurred())
			Expect(resp.StatusCode).To(Equal(http.StatusOK))
			defer resp.Body.Close()
			respBody, err := io.ReadAll(resp.Body)
			Expect(err).NotTo(HaveOccurred())
			var respBodyJSON map[string]interface{}
			errJSON := json.Unmarshal(respBody, &respBodyJSON)
			Expect(errJSON).NotTo(HaveOccurred())
			Expect(respBodyJSON).To(HaveKey("result"))
		})
	})

	AfterEach(func() {
		cancel()
	})
})
