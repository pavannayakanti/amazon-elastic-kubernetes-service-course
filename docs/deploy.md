# Deploying the Cluster

**IMPORTANT**: Ensure that all resources are created in the `us-east-1` (N. Virginia) region

this is lab step 3.

1. Clone the Repository

    Clone the required repository
    ```bash
    git clone https://github.com/pavannayakanti/amazon-elastic-kubernetes-service-course
    ```
1. Switch to Working directory

    ```bash
    git switch working-branch
    ```
1. Navigate to the EKS Directory

    Change into the EKS directory

    ```bash
    cd amazon-elastic-kubernetes-service-course/eks
    ```
1. Download the terraform
    ```bash
    wget https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip
    ```
    
1. Run the following command. It will check the lab/cloud environment for a few things that need to be correct for the cluster to deploy properly. 
   run this:
    ```bash
    source check-environment.sh
    ```
### ⚙️ Installing Terraform in AWS CloudShell

If you encounter the error `terraform: command not found`, follow these steps to install Terraform manually in AWS CloudShell:
    
        unzip terraform_1.12.2_linux_amd64.zip
        sudo mv terraform /usr/local/bin/
        terraform version
    
1. Initialize Terraform

    Initialize the Terraform configuration

    ```bash
    terraform init
    ```

1. Plan the Terraform Deployment

    Run Terraform plan to review the changes that will be applied

    ```bash
    terraform plan
    ```

1. Apply the Terraform Configuration

    Apply the Terraform configuration to provision the EKS cluster. This step will take up to 10 minutes to complete

    ```bash
    terraform apply -var="trainee_name=<trainee-name>" -var="use_predefined_role=false"
    ```

    When prompted, type `yes` to confirm.

1. Retrieve Outputs

    After Terraform completes, note the output values for `NodeAutoScalingGroup`, `NodeInstanceRole`, and `NodeSecurityGroup`. You will see something similar to this

    ```
    Outputs:

    NodeAutoScalingGroup = "demo-eks-stack-NodeGroup-UUJRINMIFPLO"
    NodeInstanceRole = "arn:aws:iam::058264119838:role/eksWorkerNodeRole-<trainee-name>"
    NodeSecurityGroup = "sg-003010e8d8f9f32bd"
    ```

    Make sure to take note of the Terraform outputs, particularly the `NodeInstanceRole`, as you will need it for the next task.


Now, proceed to [Set up access and join nodes](./nodes.md)

