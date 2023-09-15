package node_test

import (
	"flag"
	"testing"
	"time"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

var (
	kubeconfig     string
	releaseName    string
	namespace      string
	timeoutSeconds int
	timeout        time.Duration
)

func init() {
	flag.StringVar(&kubeconfig, "kubeconfig", "", "absolute path to the kubeconfig file")
	flag.StringVar(&releaseName, "name", "", "name of the primary statefulset")
	flag.StringVar(&namespace, "namespace", "", "namespace where the application is running")
	flag.IntVar(&timeoutSeconds, "timeout", 120, "timeout in seconds")
	timeout = time.Duration(timeoutSeconds) * time.Second
}

func TestNode(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Node Test Suite")
}

// func createJob(ctx context.Context, c kubernetes.Interface, name string, port string, image string, op string, topic string) error {
// 	job := &batchv1.Job{
// 		ObjectMeta: metav1.ObjectMeta{
// 			Name: name,
// 		},
// 		TypeMeta: metav1.TypeMeta{
// 			Kind: "Job",
// 		},
// 		Spec: batchv1.JobSpec{
// 			Template: v1.PodTemplateSpec{
// 				Spec: v1.PodSpec{
// 					RestartPolicy: "Never",
// 					Containers: []v1.Container{
// 						{
// 							Name:    "kafka",
// 							Image:   image,
// 							Command: []string{"kafka-topics.sh", op, "--topic", topic, "--bootstrap-server", "$(KAFKA_HOST):$(KAFKA_PORT)"},
// 							Env: []v1.EnvVar{
// 								{
// 									Name:  "KAFKA_HOST",
// 									Value: releaseName,
// 								},
// 								{
// 									Name:  "KAFKA_PORT",
// 									Value: port,
// 								},
// 							},
// 						},
// 					},
// 				},
// 			},
// 		},
// 	}

// 	_, err := c.BatchV1().Jobs(namespace).Create(ctx, job, metav1.CreateOptions{})

// 	return err
// }
