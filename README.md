# CloudDrove-task

To do this project i have created a VM in azure.

![Image](https://github.com/user-attachments/assets/0948051f-3c55-44f9-bae4-b1605d463772)

Login into vm 

![Image](https://github.com/user-attachments/assets/3e29fafa-3b00-4a64-8550-1de5c95504ca)

# Then follow the Step by Step process to achive #

## PREREQUISITES 

Install following on your VM

1. Docker

```
sudo apt update 
sudo apt install docker.io -y
```

![Image](https://github.com/user-attachments/assets/c58d8f1d-2104-4003-9dfd-d286d3818207)

![Image](https://github.com/user-attachments/assets/9cae892c-7615-4021-abb0-dc7f8ccaf17d)

``` docker --version```

![Image](https://github.com/user-attachments/assets/e1f6eac3-8bfd-4ea6-80de-7e5f3ee1b4b3)

![Image](https://github.com/user-attachments/assets/a1fcd943-e870-4632-98cb-ac58067c2cea)

2. Azure CLI

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

![Image](https://github.com/user-attachments/assets/667a9b55-c29d-4cb4-91d9-30d3bedd64a5)


``` az --version```

![Image](https://github.com/user-attachments/assets/8b7a3e8a-07c3-4197-872a-e66e77e2ac1d)


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

![Image](https://github.com/user-attachments/assets/5c4eaa86-abd8-4d41-bbe5-be25a8079e5a)

![Image](https://github.com/user-attachments/assets/58e1d536-4ada-43bd-b175-0dadd87726c6)

![Image](https://github.com/user-attachments/assets/f2bb7ec3-480f-4c4b-bc5b-9a647e3553a3)


2. Run the Container and Mount Volume
-------------------------------------

```
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  terraform-azure-env
```

![Image](https://github.com/user-attachments/assets/6ae22d08-aa7b-43d5-9016-846e066f5919)


Note: You should be inside the container, with a bash prompt like:

```
root@container-id:/workspace#
```

- Verify Terraform and azure cli versions.

```
terraform --version
az --version
```

![Image](https://github.com/user-attachments/assets/7d7a875b-4940-4dff-8142-cc0e7f0c4d52)


✅ TASK 3: Terraform Deployment
--------------------------------

- Inside container, login to Azure.

```
az login
```

![Image](https://github.com/user-attachments/assets/89d9efda-270b-42a6-909d-053062ebb375)

![Image](https://github.com/user-attachments/assets/6c747099-f388-4dfd-8d33-7ccbd27777c4)


- Run Terraform commands.

```
terraform init
```
![Image](https://github.com/user-attachments/assets/21c428be-bf82-4138-8baf-8e30a414666e)


```
terraform plan
```
![Image](https://github.com/user-attachments/assets/c8b2c19b-aed5-4ff3-a80b-646bb1178cd7)


```
terraform apply -auto-approve
```

![Image](https://github.com/user-attachments/assets/b44b5d23-9936-4313-99a8-46ba45b09e08)


- check that is resource is actually created or not by a azure cli command.

```
az group list
```
![Image](https://github.com/user-attachments/assets/22385dab-2e0a-404e-b631-97a30b24c72f)


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
![Image](https://github.com/user-attachments/assets/feb1de05-0943-41c2-a50b-ec70c5b9c57d)


- Make sure it is actually deleted in azure portal also.

![Image](https://github.com/user-attachments/assets/dab76b18-96d5-4c9d-89fb-c2caa3a715eb)







      -----------Completed------------
