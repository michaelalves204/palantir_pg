#!/bin/bash

BASHRC="$HOME/.bashrc"

cat <<'EOF' >> "$BASHRC"

# ==== Palantir aliases and functions ====
alias palantir_help='cd ~/palantir_pg && rake palantir:doc'
alias palantir_create_database='cd ~/palantir_pg && rake palantir:create_database'
alias palantir_database='cd ~/palantir_pg && rake palantir:database'
alias palantir_databases='cd ~/palantir_pg && rake palantir:databases'
alias palantir_functions='cd ~/palantir_pg && rake palantir:functions'
alias palantir_logo='cd ~/palantir_pg && rake palantir:logo'
alias palantir_logs='cd ~/palantir_pg && rake palantir:logs'
alias palantir_queries='cd ~/palantir_pg && rake palantir:queries'
alias palantir_tables='cd ~/palantir_pg && rake palantir:tables'
alias palantir_views='cd ~/palantir_pg && rake palantir:views'

palantir_delete_query() {
  cd ~/palantir_pg && query_name="$1" rake palantir:delete_query
}

palantir_edit_query() {
  cd ~/palantir_pg && query_name="$1" rake palantir:edit_query
}

palantir_query() {
  cd ~/palantir_pg && query_name="$1" rake palantir:query
}

palantir_show() {
  cd ~/palantir_pg && query_name="$1" rake palantir:show
}

palantir_set_database() {
  cd ~/palantir_pg && database_name="$1" rake palantir:set_database
}
# ==== End Palantir aliases and functions ====

EOF

source "$BASHRC"

echo "✅ palantir aliases and functions added to $BASHRC successfully!"

