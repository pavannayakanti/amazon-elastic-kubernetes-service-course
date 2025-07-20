# 🌩️ Scale Down EKS Node Group to Zero (Reduce EC2 Cost)

To reduce AWS EC2 cost without fully destroying your EKS cluster, you can **scale down the worker nodegroup's Auto Scaling Group to 0**. This will shut down EC2 instances while preserving the EKS control plane and config.

---

## ✅ Objective
Set:
- Desired capacity = 0
- Minimum capacity = 0
- Maximum capacity = 0

This ensures **no EC2 nodes** are running in the node group.

---

## 🔧 Steps

1. **Login to AWS Console**
   - Open: [EC2 Auto Scaling Groups (N. Virginia)](https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#AutoScalingGroups:)

2. **Find Your Node Group**
   - Look for the Auto Scaling Group with a name like:
     ```
     eks-cluster-stack-NodeGroup-*
     ```
     The name usually begins with your EKS cluster name (e.g., `demo-eks-pavan`).

3. **Click on the Auto Scaling Group**
   - This opens the details page for the group.

4. **Click “Edit”**
   - You'll see fields for:
     - **Desired Capacity**
     - **Minimum Capacity**
     - **Maximum Capacity**

5. **Set All Three to `0`**
   - This immediately triggers a scale-in and shuts down EC2 instances.

6. **Click “Update” or “Save”**

---

## 🧪 Optional: Verify from CLI

You can run:
```bash
aws autoscaling describe-auto-scaling-groups --region us-east-1
```
Or verify from:
```bash
kubectl get nodes
```
You should see no nodes available.

---

## ♻️ To Revert

Later, if needed, update the ASG settings:
- Desired capacity = 1 (or 2)
- Min = 1
- Max = 3 (or as needed)

---

## 💡 Why This Works
This does not destroy the cluster. Your EKS control plane and configs stay intact. You only stop EC2 usage to reduce cost — perfect for training or paused environments.

---

## 📌 Tip
You can use this command as an alternative:
```bash
aws autoscaling update-auto-scaling-group \
  --auto-scaling-group-name <your-ASG-name> \
  --min-size 0 --max-size 0 --desired-capacity 0 \
  --region us-east-1
```
