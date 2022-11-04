#!/bin/bash
echo -e "\nBefore running the script lets check terraform code validation\n"

terraform validate
if [ $? -eq 0 ]
    then
        echo -e "\t<<< Great Work >>>\n"
    else
        echo -e " \t<<< Please check your code again >>> \n"
fi
sleep 2
echo "You Have The Following Workspaces"
terraform workspace list
sleep 2
echo "You Are In *$(terraform workspace show)* Workspace"
echo "Do You Want To Continue At The Same Workspace"
read answer
if [ "$answer" = "no" ]
then
        echo -e "\n Ok Let's Go On"
        echo -e "\n You Have The Following Workspaces\n"
        PS3="Please Select Your Workspace : "
        items=("default" "dev" "prod")

        select item in "${items[@]}" Quit
        do
            case $REPLY in
                1) echo "Selected item $item"
                    terraform workspace select $item
                    echo "You Are Now In *$(terraform workspace show)* Workspace"
                    terraform plan -var-file prod.tfvars
                    # ansible-playbook -i ansiblerole/inventory --private-key ~/Projects/terraform.pem ansiblerole/main.yaml
                    break;;
                2) echo "Selected item $item"
                    terraform workspace select $item
                    echo "You Are Now In *$(terraform workspace show)* Workspace"
                    terraform apply -var-file dev.tfvars
                    break;;

                3) echo "Selected item $item"
                    terraform workspace select $item
                    echo "You Are Now In *$(terraform workspace show)* Workspace"
                    terraform apply -var-file prod.tfvars
                    break;;
                *) echo "Ooops - unknown choice $REPLY";;
            esac
        done

else
    echo "You Are Now In *$(terraform workspace show)* Workspace"
    terraform plan -var-file prod.tfvars
fi
ansible-playbook --private-key ~/lap2/terraform.pem main.yaml