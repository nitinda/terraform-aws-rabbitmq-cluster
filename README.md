# _terraform-aws-rabbitmq-cluster_
_RabbitMQ Cluster on AWS EC2 model, using EC2 peer discovery._

_RabbitMQ cluster on AWS EC2 with high availability. We’ll set up a 2 or 3 node RabbitMQ cluster on AWS EC2 with high availability policy. The purpose of this cluster will be to provide failover in case of any node failure, so consumers will be functional even if one or two nodes are down._

<!--BEGIN STABILITY BANNER-->
---

![_Code : Stable_](https://img.shields.io/badge/Code-Stable-brightgreen?style=for-the-badge&logo=github)

> **_This is a stable example. It should successfully build out of the box_**
>

---
<!--END STABILITY BANNER-->


## _Pre-requisite_

_This module needs Terraform 0.12.24 or newer._
_You can download the latest Terraform version from [_here_](https://www.terraform.io/downloads.html)._

_This module deploys aws services details are in respective feature branches._


---

## _Features_

_Below we are able to check the resources that are being created as part of this module call:_

- **_VPC_**
- **_Launch Template_**
- **_Auto Scalling Group_**
- **_Security Group_**
- **_Load Balancer Listener_**
- **_Target Group_**
- **_Application Load Balancer_**



---



## _Usage_

## _Using this repo_

_To use this module, add the following call to your code:_


```tf
git clone https://github.com/nitinda/terraform-aws-rabbitmq-cluster.git
cd terraform-aws-rabbitmq-cluster
make plan
make apply
```

---



## _Authors_
_Module maintained by Module maintained by the -_ **_Nitin Das_**
