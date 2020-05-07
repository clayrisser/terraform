# terraform-rancher

[![GitHub stars](https://img.shields.io/github/stars/codejamninja/terraform-rancher.svg?style=social&label=Stars)](https://github.com/codejamninja/terraform-rancher)

> Initialize rancher 2 with terraform

Please ★ this repo if you found it useful ★ ★ ★

## Dependencies

* [AWS CLI](https://aws.amazon.com/cli)
* [Terraform](https://terraform.io)
* [GNU Make](https://www.gnu.org/software/make)
* [Python 3](https://www.python.org)

## Usage

### Configure AWS CLI

```sh
aws configure
```

### Deploy Rancher

```sh
cd aws/rancher
```

Set the variables the _.env_ file

```sh
source .env
terraform init
terraform state push .terraform/terraform.tfstate
terraform apply
```

### Deploy Cluster

```sh
cd aws/cluster
cp .env.template .env
```

Set the variables the _.env_ file

```sh
source .env
terraform init
terraform state push .terraform/terraform.tfstate
terraform apply
```

## Support

Submit an [issue](https://github.com/codejamninja/terraform-rancher/issues/new)

## Contributing

Review the [guidelines for contributing](https://github.com/codejamninja/terraform-rancher/blob/master/CONTRIBUTING.md)

## License

[MIT License](https://github.com/codejamninja/terraform-rancher/blob/master/LICENSE)

[Jam Risser](https://codejam.ninja) © 2018

## Changelog

Review the [changelog](https://github.com/codejamninja/terraform-rancher/blob/master/CHANGELOG.md)

## Credits

* [Jam Risser](https://codejam.ninja) - Author


## Support on Liberapay

A ridiculous amount of coffee ☕ ☕ ☕ was consumed in the process of building this project.

[Add some fuel](https://liberapay.com/codejamninja/donate) if you'd like to keep me going!

[![Liberapay receiving](https://img.shields.io/liberapay/receives/codejamninja.svg?style=flat-square)](https://liberapay.com/codejamninja/donate)
[![Liberapay patrons](https://img.shields.io/liberapay/patrons/codejamninja.svg?style=flat-square)](https://liberapay.com/codejamninja/donate)
