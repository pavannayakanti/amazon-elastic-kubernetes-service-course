# 🚀 Configure AWS Load Balancer Controller on EKS

This guide helps you configure the **AWS Load Balancer Controller** in your Amazon EKS cluster (`demo-eks`).

---

## 📁 Step 1: Locate the YAML File

Navigate to the directory containing the controller YAML:

```bash
cd /root/amazon-elastic-kubernetes-service-course/eks
```

Locate the file:
```bash
ls | grep v2_7_2_full.yaml
```

---

## ✏️ Step 2: Edit the YAML File

Open the `v2_7_2_full.yaml` file in your editor and update the cluster name:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aws-load-balancer-controller
  namespace: kube-system
spec:
  template:
    spec:
      containers:
        - args:
            - --cluster-name=demo-eks   # ✅ Set your cluster name here
```

---

## ✅ Step 3: Apply the YAML File

Run the following command to create the necessary resources:

```bash
kubectl apply -f v2_7_2_full.yaml
```

This will deploy the AWS Load Balancer Controller into your cluster.

---

## 🔍 Step 4: Verify the Controller Is Running

Check if the controller pod is running correctly:

```bash
kubectl get deployment aws-load-balancer-controller -n kube-system
```

You should see the controller deployment in a healthy, running state.

---

## 📚 References

For more in-depth installation steps and configuration options, visit:

👉 [Add Controller to Cluster](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.7/deploy/installation/#add-controller-to-cluster)
