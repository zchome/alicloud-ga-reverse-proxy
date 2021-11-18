<p align="center">
<a href=" https://www.alibabacloud.com"><img src="https://aliyunsdk-pages.alicdn.com/icons/AlibabaCloud.svg"></a>
</p>

The Alibaba Cloud Terraform modules for PoC. 


## Requirements
+ To use Alibaba Cloud Terraform modules for PoC, you must have an Alibaba Cloud account with an `AccessKey ID` and `AccessKey Secret`.

## Installation
+ Install terraform cli.
+ Init project and refer modules.

## Usage(Terragrunt)
+ Export `ALICLOUD_ACCESS_KEY` `ALICLOUD_SECRET_KEY` `ALICLOUD_REGION` variables to env.
+ Include required modules as your requirement.
+ Execute `terragrunt run-all init` & `terragrunt run-all apply` to apply resources on the parent directory in given region.

## Remarks
* When you use ga (Global Accelorator) module, please set `ALICLOUD_REGION` to `cn-hangzhou`