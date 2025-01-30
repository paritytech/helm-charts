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
	namespace      string
	timeoutSeconds int
	timeout        time.Duration
)

const (
	PollingInterval = 1 * time.Second
)

func init() {
	flag.StringVar(&kubeconfig, "kubeconfig", "", "absolute path to the kubeconfig file")
	flag.StringVar(&namespace, "namespace", "", "namespace where the application is running")
	flag.IntVar(&timeoutSeconds, "timeout", 300, "timeout in seconds")
	timeout = time.Duration(timeoutSeconds) * time.Second
}

func TestNode(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Node Test Suite")
}
