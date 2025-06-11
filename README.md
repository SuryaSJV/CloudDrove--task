# CloudDrove-task

To do this project i have created a VM in azure.

![Image](https://github.com/user-attachments/assets/0ba3be82-5c67-4ceb-b25d-6a2de079fb22)

Login into vm 

![Image](https://github.com/user-attachments/assets/6c7d2472-8380-454e-bc3d-6c53477212b9)


# Then follow the Step by Step process to achive #

## PREREQUISITES 

Install following on your VM

1. Docker

```
sudo apt update 
sudo apt install docker.io -y
```

![Image](https://github.com/user-attachments/assets/cadc670e-1f52-4cc6-9b23-6661050569ce)

![Image](https://github.com/user-attachments/assets/c98aae30-347a-403b-86a6-411e3faf11f2)

``` docker --version```

![Image](https://github.com/user-attachments/assets/3749f353-86d8-4231-84fc-6ac2bf2aa5b7)

![Image](https://github.com/user-attachments/assets/997e0580-6b74-4ccf-99cc-f6b4dd9f2be1)

2. Azure CLI

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

![Image](https://github.com/user-attachments/assets/e5117d52-2712-4f7a-93d9-39bbbcbd043e)


``` az --version```

![Image](https://github.com/user-attachments/assets/921ac575-e253-4ac3-8158-87c686e4b0ce)


✅ TASK 1: Docker Image Preparation
-------------------------------------

🧱 STEP 1: Create Project Folder


```
mkdir terraform-docker-project 
cd terraform-docker-project
```

- i have already written a Dockerfile, make sure to use that.

- then create a Dockerimage out of it.
```
docker build -t terraform-azure-env .
```

✅ TASK 2: Build and Run the Container
---------------------------------------

1. Create local Terraform file
------------------------------

- we have tasked to create a Resource Group in azure using terraform, for that i have already wrote a Terraform confiuration file named "main.tf" to create Azurerm Resource Group, take a look at it.

![Image](https://github.com/user-attachments/assets/d34a2803-ff06-4efe-bc6c-53d25a2e2f5a)


2. Run the Container and Mount Volume
-------------------------------------

```
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  terraform-azure-env
```

![Image](https://github.com/user-attachments/assets/fac0fd74-f865-4b40-a499-33d1c4d5946e)

![Image](https://github.com/user-attachments/assets/89b8ab58-cc09-40f0-bf1a-32ab25251f4d)

![Image](https://github.com/user-attachments/assets/737ecc08-d14c-4cbd-880d-a5aa67874158)


Note: You should be inside the container, with a bash prompt like:

```
root@container-id:/workspace#
```

- Verify Terraform and azure cli versions.

```
terraform --version
az --version
```

![Image](https://github.com/user-attachments/assets/73e3fc1d-243c-47b7-beb6-04f73897e34c)


✅ TASK 3: Terraform Deployment
--------------------------------

- Inside container, login to Azure.

```
az login
```

![Image](https://github.com/user-attachments/assets/02658ffc-78b6-4bea-8fd7-4318fd7d9981)

![Image](https://github.com/user-attachments/assets/52ce0bb3-0175-481b-af30-84b3f239b98b)


- Run Terraform commands.

```
terraform init
```
![Image](https://github.com/user-attachments/assets/429c46a3-a34c-4ad3-85f0-8d6afa193b50)


```
terraform plan
```
![Image](https://github.com/user-attachments/assets/c80469bf-242b-4bc0-8e60-55d18bdb4d06)


```
terraform apply -auto-approve
```

![Image](https://github.com/user-attachments/assets/6a66a3cd-afaf-4150-9f99-aeefdf0fd07b)


- check that is resource is actually created or not by a azure cli command.

```
az group list
```
![Image](https://github.com/user-attachments/assets/cfd21426-6525-4488-be9c-2fa19aa2ff7c)


✅ TASK 4: Automation & Cleanup
---------------------------------

- Update Dockerfile to auto-run Terraform

Modify the last lines of Dockerfile:

```
CMD ["/bin/bash", "-c", "if ls /workspace/*.tf > /dev/null 2>&1; then terraform init && terraform apply -auto-approve; else bash; fi"]
```
- Re-run the container with volume mounted.

```
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  terraform-azure-env
```


- run destroy command so that the resources those were craeted willbe deleted.

```
terraform destroy -auto-approve
```
![Image](https://github.com/user-attachments/assets/c1692cd7-95d4-450a-be2a-e26df88866bd)


- Make sure it is actually deleted in azure portal also.

![Image](https://github.com/user-attachments/assets/2234c6ff-0933-42f7-be74-b961fec0db84)







      -----------Completed------------
