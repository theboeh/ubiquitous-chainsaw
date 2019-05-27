## Task Description

Here is the task as it was given to me:

> Using the AWS free tier in the N. Virginia region, automate all steps necessary to complete the following exercise:
>
> In your personal Virtual Private Cloud, create two EC2 instances using the type t2.micro.
>
> Instance “A”:
>
> * Operating system image 0080e4c5bc078760e
> * The root volume should be 9 GB in size.
> * Create an additional EBS volume
>   * No encryption.
>   * Volume type gp2 with 1 GB of storage.
>   * File system of XFS.
>   * Create the directory /dataup
>   * Mount the volume.
>   * Reboot the instance.
>
> Instance “B”:
>
> * Operating system image 05a36d3b9aa4a17ac
> * The root volume should be 9 GB in size.
> * Create two EBS volume and configure for RAID 0
>   * Encrypted.
>   * Volume type gp2 with 1 GB of storage.
>   * File system of XFS.
>   * Create the directory /datadown
>   * Mount the volume.
>   * Reboot the instance.
>
> Create an S3 bucket:
>
> * The bucket policy should enforce data encryption in flight.
> * The bucket should have encryption for objects at rest.
>
> Using the AWS CLI:
>
> * On instance “A” create a test file in the directory /dataup and upload it to the S3 bucket.
> * On instance “B” pull the test file from the S3 bucket to the /datadown directory.
