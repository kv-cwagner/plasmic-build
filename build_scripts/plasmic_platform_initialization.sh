#!/bin/bash
# A script to source multiple scripts sequentially while preserving the original directory,
# using pushd/popd so that any directory changes made by the sourced scripts are reverted.

# List of scripts to source
scripts=(
  "build_scripts/setup_database.sh"
  "build_scripts/migrate_dev_bundles.sh"
  "build_scripts/run_schema_migrations.sh"
  "build_scripts/seed_database.sh"
  "build_scripts/update_plume.sh"
)

# Save the original working directory
original_dir="$(pwd)"

for script in "${scripts[@]}"; do
  script_path="./$script"

  echo "-----------------------------------"
  echo "Sourcing $script..."

  # Check if the script file exists
  if [ ! -f "$script_path" ]; then
    echo "Error: $script_path not found!"
    exit 1
  fi
  
  # Ensure the script is executable (optional when sourcing, but may be needed if the file mode is checked elsewhere)
  if [ ! -x "$script_path" ]; then
    chmod +x "$script_path"
  fi

  # Use pushd to save the current directory on the stack.
  pushd "$original_dir" > /dev/null

  # Source the script so it executes in the current shell context.
  source "$script_path"
  exit_status=$?

  # Use popd to return to the original directory.
  popd > /dev/null

  # Check if the script executed successfully
  if [ $exit_status -ne 0 ]; then
    echo "Error: $script failed with exit status $exit_status. Halting."
    exit $exit_status
  fi

  echo "$script completed successfully."
done

echo "-----------------------------------"
echo "All scripts have run successfully."