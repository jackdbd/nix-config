{
  config,
  lib,
  pkgs,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      # Data Build Tool with adapters
      (dbt.withAdapters (adapters: [
        adapters.dbt-bigquery
        adapters.dbt-postgres
      ]))
    ];
  };
}
