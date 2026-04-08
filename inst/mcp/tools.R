# MCP tool definitions for the FORCIS package
#
# This file is sourced by mcptools::mcp_server() and must return a list of
# ellmer::tool() objects.

# ---- Database version tools ------------------------------------------------

tool_get_available_versions <- ellmer::tool(
  forcis::get_available_versions,
  name = "get_available_versions",
  description = paste(
    "Get all available versions of the FORCIS foraminifera database by",
    "querying the Zenodo API. Returns a table with publication date, version",
    "label, and access right for each version."
  )
)

tool_get_version_metadata <- ellmer::tool(
  forcis::get_version_metadata,
  name = "get_version_metadata",
  description = paste(
    "Get detailed metadata for a specific version of the FORCIS database,",
    "including title, DOI, publication date, description, creators, keywords,",
    "license, and file list. If no version is specified, the latest version",
    "is used."
  ),
  arguments = list(
    version = ellmer::type_string(
      paste(
        "The version label (e.g., '08'). Use get_available_versions() to list",
        "available versions. If omitted, the latest version is used."
      ),
      required = FALSE
    )
  )
)

# ---- Reference data tools --------------------------------------------------

tool_get_ocean_names <- ellmer::tool(
  forcis::get_ocean_names,
  name = "get_ocean_names",
  description = paste(
    "Get the names of World oceans according to the IHO Sea Areas dataset",
    "version 3. Useful when filtering FORCIS data by ocean with",
    "filter_by_ocean()."
  )
)

# ---- Database download tool -------------------------------------------------

tool_download_forcis_db <- ellmer::tool(
  forcis::download_forcis_db,
  name = "download_forcis_db",
  description = paste(
    "Download the entire FORCIS foraminifera database as CSV files from",
    "Zenodo. Files are saved in the specified folder under a versioned",
    "subdirectory (e.g., forcis-db/version-08/). This must be called before",
    "any read_*_data() function."
  ),
  arguments = list(
    path = ellmer::type_string(
      "The folder path where the database will be saved."
    ),
    version = ellmer::type_string(
      paste(
        "The version number as a two-digit string (e.g., '08').",
        "If omitted, the latest version is downloaded."
      ),
      required = FALSE
    ),
    check_for_update = ellmer::type_boolean(
      paste(
        "If TRUE (default), check whether a newer version is available",
        "on Zenodo and print an informative message."
      ),
      required = FALSE
    ),
    overwrite = ellmer::type_boolean(
      "If TRUE, overwrite previously downloaded files. Default is FALSE.",
      required = FALSE
    ),
    timeout = ellmer::type_integer(
      paste(
        "Timeout in seconds for downloading files from Zenodo.",
        "Default is 60. Increase for slow connections."
      ),
      required = FALSE
    )
  )
)

# ---- Data reading tools -----------------------------------------------------

make_read_tool <- function(fun, name, device_description) {
  ellmer::tool(
    fun,
    name = name,
    description = paste(
      "Read the FORCIS",
      device_description,
      "data from a locally downloaded",
      "database. The download_forcis_db() function must be called first to",
      "store the database locally. Returns a tibble with all columns for this",
      "sampling device."
    ),
    arguments = list(
      path = ellmer::type_string(
        "The folder path where the FORCIS database was saved."
      ),
      version = ellmer::type_string(
        paste(
          "The version number as a two-digit string (e.g., '08').",
          "If omitted, the latest version is used."
        ),
        required = FALSE
      ),
      check_for_update = ellmer::type_boolean(
        paste(
          "If TRUE (default), check whether a newer version is available",
          "on Zenodo."
        ),
        required = FALSE
      )
    )
  )
}

tool_read_cpr_north_data <- make_read_tool(
  forcis::read_cpr_north_data,
  "read_cpr_north_data",
  "CPR North (Continuous Plankton Recorder, Northern Hemisphere)"
)

tool_read_cpr_south_data <- make_read_tool(
  forcis::read_cpr_south_data,
  "read_cpr_south_data",
  "CPR South (Continuous Plankton Recorder, Southern Hemisphere)"
)

tool_read_plankton_nets_data <- make_read_tool(
  forcis::read_plankton_nets_data,
  "read_plankton_nets_data",
  "plankton nets"
)

tool_read_pump_data <- make_read_tool(
  forcis::read_pump_data,
  "read_pump_data",
  "pump"
)

tool_read_sediment_trap_data <- make_read_tool(
  forcis::read_sediment_trap_data,
  "read_sediment_trap_data",
  "sediment trap"
)

# ---- Return all tools -------------------------------------------------------

list(
  tool_get_available_versions,
  tool_get_version_metadata,
  tool_get_ocean_names,
  tool_download_forcis_db,
  tool_read_cpr_north_data,
  tool_read_cpr_south_data,
  tool_read_plankton_nets_data,
  tool_read_pump_data,
  tool_read_sediment_trap_data
)
