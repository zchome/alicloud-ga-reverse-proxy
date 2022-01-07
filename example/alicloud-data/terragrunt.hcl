terraform {
    source = "${get_parent_terragrunt_dir()}/modules/alicloud-data"
}

include {
    path = find_in_parent_folders()
}

inputs = {

}