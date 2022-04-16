# csa-in-grcn

# CSA-in-GRCN
> 本项目包含GCP上的Terraform实现及相关脚本，为了让用户方便地体验到到[Google Cloud Communicaty Security Analytics](https://github.com/GoogleCloudPlatform/security-analytics) 使用场景在BigQuery上的实现和价值

## Table of Contents
* [Background Information 背景](#background-information-背景)
* [Major GCP configurations 主要的GCP基础设施配置](#Major-GCP-configurations-主要的GCP基础设施配置)
* [pre-requisite 前提要求](#pre-requisite-前提要求)
* [Screenshots](#screenshots)
* [Setup 配置步骤](#setup-配置步骤)
* [Usage](#usage)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)
<!-- * [License](#license) -->


## Background Information 背景
- Provide general information about your project here.
- What problem does it (intend to) solve?
- What is the purpose of your project?
- Why did you undertake it?
<!-- You don't have to answer all the questions - just the ones relevant to your project. -->


## Major GCP configurations 主要的GCP基础设施配置
将Org，Folder或者Project层面的日志转发到BigQuery dataset的[文档](https://cloud.google.com/logging/docs/export/aggregated_sinks)

- 生成对应的BigQuery Datasets
- 在对应的层面配置log sink，将日志转发目的地指向上面的BigQuery Datasets
- 在BigQuery Datasets上，绑定对应的logging服务账号的BigQuery Data Editor角色（roles/bigquery.dataEditor）




## pre-requisite 前提要求

### 建立或者指配一个用于Terraform部署的服务账号（建议可以在CI/CD的project中，也可以在收容日子的BigQuery数据集所在的Project中）
对于要收集日子的Org，Folder，Project层面，授予该服务账号日志配置写入权限 (roles/logging.configWriter) 。[文档](https://cloud.google.com/logging/docs/access-control)
- 在收容日子的BigQuery数据集所在的Project中，授予该服务账号BigQuery数据编辑权限(roles/bigquery.dataEditor) ，这样部署过程中，该服务账号可以支持Terraform去建立和编辑对应的数据集（dataset）

### 当前命令行所在运行环境中的账号可以有借用（impersonate）上述服务账号的权限。
在本项目中，使用[借用（impersonate）服务账号的模式运行Terraform](https://cloud.google.com/blog/topics/developers-practitioners/using-google-cloud-service-account-impersonation-your-terraform-code)，这样不用下载使用带私钥的服务账号凭据，可以避免一些风险。当前命令行所在运行环境中的账号需要有借用（impersonate）上述服务账号的权限如下
- Service Account User (roles/iam.serviceAccountUser)
- Service Account Token Creator (roles/iam.serviceAccountTokenCreator)

如果是使用Cloud build部署本项目中的配置，需要对应的Cloud Build服务账号有借用（impersonate）上述服务账号的权限。

### 一个GCS Bucket用来存放[Terraform状态信息](https://cloud.google.com/docs/terraform/resource-management/store-state). 上述的服务账号需要有该bucket以下权限.
- storage.buckets.create
- storage.buckets.list
- storage.objects.get
- storage.objects.create
- storage.objects.delete
- storage.objects.update
这个GCS Bucket的信息需要配置在[backend.tf](https://github.com/ChrisYangGKC/csa-in-grcn/blob/master/backend.tf)当中。


## Screenshots
![Example screenshot](./img/screenshot.png)
<!-- If you have screenshots you'd like to share, include them here. -->


## Setup 配置步骤

### 第一步，下载代码，并准备好匹配当前环境的Terraform配置参数

首先在命令行中，下载代码到部署环境中

`git clone https://github.com/ChrisYangGKC/csa-in-grcn.git`

然后进入到代码目录中

`cd csa-in-grcn`

之后把配置参数文件`terraform.tfvars`准备好

`cp ./terraform.tfvars.backup ./terraform.tfvars`

terraform.tfvars中的主要的配置参数如下
| 名称  | 说明 |
| ------------- | ------------- |
| org_id  | GCP中当前环境中的Organization ID  |
| prod_folder  | 需要采集日志的生产环境的folder ID  |
| test_folder  | 需要采集日志的测试或者开发环境的folder ID  |
| log_project_id  | 收集日志指向的BigQuery数据集所在的GCP project ID  |
| prod_projects  | 需要采集日志的生产环境的project ID列表 |
| test_projects  | 需要采集日志的测试或者开发环境的project ID列表  |
| prod_dataset  | BigQuery中收容的生产环境日志的dataset  |
| test_dataset  | BigQuery中收容的测试或者开发环境日志的dataset  |
| viewer_prod_dataset  | BigQuery中生产环境dataset的viewer权限用户或者用户组 |
| viewer_test_dataset  | BigQuery中测试或者开发环境dataset的viewer权限用户或者用户组 |
| test_dataset  | BigQuery中收容的测试或者开发环境日志的dataset  |
| owner_prod_dataset  | BigQuery中生产环境dataset的Owner权限用户或者用户组 |
| owner_test_dataset  | BigQuery中测试或者开发环境dataset的Owner权限用户或者用户组 |

在这当中，organization层面的日志为单独收集
`prod_folder`和`test_folder`的配置中，既包含了其folder层面的日志，还包括了该folder所包含的所有子folder和projects的日志。所以，如果需要收集日志的project全部包含在当前folder中的话，`prod_projects`和`test_projects`这两个部分不是必须的。

### 第二步，部署相关的GCP云资源和配置

初始化Terraform

`terraform init`

然后预览需要做出的所有的GCP基础设施变更

`terraform plan`

一切没有问题的话，可以进行部署

`terraform apply --auto-approve`

### 第三步，确认配置正确

如果上述第二步（#第二步，部署相关的GCP云资源和配置）运行正确，可以首先在对应的Org，folder，project层面的logging sink配置（console->`logging`->`logging router`）是否存在

也需要在收容日志的BigQuery dataset的权限列表里确认对应的服务账号是否配置正确。根据实际配置情况，可能会有下列三种类型的服务账号

| 类型  | 说明 |
| ------------- | ------------- |
| oxxxxxxxxxxxx-xxxxxx@gcp-sa-logging.iam.gserviceaccount.com | Organization层面的logging服务账号的identity |
| fxxxxxxxxxxxx-xxxxxx@gcp-sa-logging.iam.gserviceaccount.com | 已配置的folder层面的logging服务账号的identity |
| pxxxxxxxxxxxx-xxxxxx@gcp-sa-logging.iam.gserviceaccount.com | 已配置的project层面的logging服务账号的identity |

BigQuery当中的数据集可以立刻建好，取决于对应环境中的服务活跃程度，可能需要等一些时间看到数据集中的BigQuery数据表（Table），以下是一些典型的自动生成的数据表

| 名称  | 说明 |
| ------------- | ------------- |
| cloudaudit_googleapis_com_activity | 所有的admin activity审计日志（默认打开，免费） |
| cloudaudit_googleapis_com_data_access | 所有的data access审计日志（只有BigQuery数据集data access审计日志默认打开且免费，其他默认关闭，如果打开需要收费） |
| compute_googleapis_com_firewall | 所有的VPC防火墙策略日志（默认关闭，如果打开需要收费） |
| compute_googleapis_com_nat_flows | 所有的NAT日志（默认关闭，如果打开需要收费） |
| compute_googleapis_com_vpc_flows | 所有的VPC flow日志 （默认关闭，如果打开需要收费）|
| ids_googleapis_com_threat | 所有的Cloud IDS检测到的威胁告警日志（如果使用付费的Cloud IDS的话，默认打开）  |
| requests | 所有的Global Load Balancer的访问日志（默认关闭，如果打开需要收费）  |

如果要预估打开的log的收费情况，可以访问[这里]（https://cloud.google.com/stackdriver/estimating-bills#logs-resource-usage）


## Usage
How does one go about using it?
Provide various use cases and code examples here.

`write-your-code-here`


## Project Status
Project is: _in progress_ / _complete_ / _no longer being worked on_. If you are no longer working on it, provide reasons why.


## Room for Improvement
Include areas you believe need improvement / could be improved. Also add TODOs for future development.

Room for improvement:
- Improvement to be done 1
- Improvement to be done 2

To do:
- Feature to be added 1
- Feature to be added 2


## Acknowledgements
Give credit here.
- This project was inspired by...
- This project was based on [this tutorial](https://www.example.com).
- Many thanks to...


## Contact
Created by [@flynerdpl](https://www.flynerd.pl/) - feel free to contact me!


<!-- Optional -->
<!-- ## License -->
<!-- This project is open source and available under the [... License](). -->

<!-- You don't have to include all sections - just the one's relevant to your project -->


