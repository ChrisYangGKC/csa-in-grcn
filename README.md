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
- Tech 1 - version 1.0
- Tech 2 - version 2.0
- Tech 3 - version 3.0


## pre-requisite 前提要求
List the ready features here:
- Awesome feature 1
- Awesome feature 2
- Awesome feature 3


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

### 第二步，部署相关的GCP云资源和配置

### 第三步，确认配置正确




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


