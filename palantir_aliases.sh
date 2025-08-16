#!/bin/bash

echo "alias palantir_help='cd ~/palantir_pg && rake palantir:doc'" >> ~/.bashrc
echo "alias palantir_create_database='cd ~/palantir_pg && rake palantir:create_database'" >> ~/.bashrc
echo "alias palantir_database='cd ~/palantir_pg && rake palantir:database'" >> ~/.bashrc
echo "alias palantir_databases='cd ~/palantir_pg && rake palantir:databases'" >> ~/.bashrc
echo "alias palantir_delete_query='cd ~/palantir_pg && rake palantir:delete_query'" >> ~/.bashrc
echo "alias palantir_edit_query='cd ~/palantir_pg && rake palantir:edit_query'" >> ~/.bashrc
echo "alias palantir_functions='cd ~/palantir_pg && rake palantir:functions'" >> ~/.bashrc
echo "alias palantir_logo='cd ~/palantir_pg && rake palantir:logo'" >> ~/.bashrc
echo "alias palantir_logs='cd ~/palantir_pg && rake palantir:logs'" >> ~/.bashrc
echo "alias palantir_queries='cd ~/palantir_pg && rake palantir:queries'" >> ~/.bashrc
echo "alias palantir_query='cd ~/palantir_pg && rake palantir:query'" >> ~/.bashrc
echo "alias palantir_show='cd ~/palantir_pg && rake palantir:show'" >> ~/.bashrc
echo "alias palantir_set_database='cd ~/palantir_pg && rake palantir:set_database'" >> ~/.bashrc
echo "alias palantir_tables='cd ~/palantir_pg && rake palantir:tables'" >> ~/.bashrc
echo "alias palantir_views='cd ~/palantir_pg && rake palantir:views'" >> ~/.bashrc

source ~/.bashrc

echo "Aliases added successfully."
