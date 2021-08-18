# Test project
1. Use terraform to set up the following scenario on Azure. To simplify things, you can assume local storage for the state file.


    - Create three linux VMs, named VM#1, VM#2, and VM#3  in the Canada Central region in Azure. Use Ubuntu 20.04 LTS as the operating system offering.
    - Set up networking on VM#1 so that:
      - SSH traffic is only permitted by a static IP (use 174.91.158.103)
    - Set up networking on VM#2 and VM#3 so that:
      - incoming traffic on HTTPS traffic is permitted from anywhere
      - incoming SSH traffic is only accessible from VM#1
      - all other incoming traffic is denied


2. Using the following kubernetes resources define a NetworkSecurityPolicy such that:

    - The rails pod accepts incoming HTTP traffic over port 8080
    - The rails pod is permitted to send traffic outbound to a specific static IP over port 5432
    - The rails pod is permitted to send traffic outbound to a specific static IP over port 6379
    - The rails pod does not accept any other incoming or outgoing traffic
    - The sidekiq pod can communicate outbound to a the same static IP over port 6379 as the    rails pod is configured with
    - The sidekiq pod can not make any other communication inbound or outbound

 ## Assumptions
 - There's is no Deployment or Pod definition creating pods with "rails" explicitly in their name. I'm assuming rails pod are the one being created by testapp-api deployment
 - There's is no Deployment or Pod definition creating pods with "sidekiq" explicitly in their name. I'm assuming rails pod are the one being created by testapp-sidekiq deployment
 - It's not specified if "specific static IPs" come as a Helm variables so they're hardcoded for simplicity. It would be a good practice for those IPs to be Helm variables

