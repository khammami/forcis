# MCP tool definitions for the FORCIS package
#
# This file is sourced by mcptools::mcp_server() and must return a list of
# ellmer::tool() objects.

# ---- Help tool --------------------------------------------------------------

forcis_mcp_help <- function(topic = "overview") {
  switch(
    topic,
    "overview" = paste(
      "FORCIS MCP Server",
      "==================",
      "",
      "The FORCIS MCP server provides tools to access and explore the FORCIS",
      "database, a global dataset of planktonic foraminifera abundance and",
      "distribution in the World Ocean.",
      "",
      "The database is hosted on Zenodo and maintained by the FORCIS working",
      "group. The forcis R package (https://docs.ropensci.org/forcis/) is the",
      "official interface to download, read, filter, and analyze FORCIS data.",
      "",
      "Call get_help() with one of the following topics for more details:",
      "- 'tools'    : List all available MCP tools with descriptions.",
      "- 'database' : Learn about the FORCIS database content and structure.",
      "- 'package'  : Discover additional forcis R package capabilities.",
      "- 'workflow' : See a recommended step-by-step analysis workflow.",
      sep = "\n"
    ),

    "tools" = paste(
      "Available MCP Tools",
      "====================",
      "",
      "Help:",
      "- get_help: Return documentation about this MCP server. Accepts a",
      "  'topic' argument: overview, tools, database, package, or workflow.",
      "",
      "Database versions:",
      "- get_available_versions: List all versions of the FORCIS database",
      "  available on Zenodo.",
      "- get_version_metadata: Get detailed metadata (DOI, creators,",
      "  keywords, files) for a specific database version.",
      "",
      "Reference data:",
      "- get_ocean_names: List World ocean names from the IHO Sea Areas",
      "  dataset. Useful for filtering data by ocean.",
      "- get_species_names: List all known planktonic foraminifera species",
      "  in the FORCIS database. Optionally filter by taxonomy level",
      "  (LT, VT, OT). Useful before filtering data by species.",
      "",
      "Download:",
      "- download_forcis_db: Download the full FORCIS database from Zenodo",
      "  as CSV files. Must be called before reading any data.",
      "",
      "Read data (one tool per sampling device):",
      "- read_cpr_north_data: Read Continuous Plankton Recorder (CPR)",
      "  data from the Northern Hemisphere.",
      "- read_cpr_south_data: Read CPR data from the Southern Hemisphere.",
      "- read_plankton_nets_data: Read plankton nets data.",
      "- read_pump_data: Read pump data.",
      "- read_sediment_trap_data: Read sediment trap data.",
      sep = "\n"
    ),

    "database" = paste(
      "The FORCIS Database",
      "====================",
      "",
      "FORCIS is a global database of planktonic foraminifera abundance and",
      "distribution in the World Ocean. It compiles data from five sampling",
      "devices:",
      "",
      "1. CPR North - Continuous Plankton Recorder, Northern Hemisphere",
      "2. CPR South - Continuous Plankton Recorder, Southern Hemisphere",
      "3. Plankton nets - Various net-based sampling",
      "4. Pumps - Pump-based water sampling",
      "5. Sediment traps - Time-series particle collectors",
      "",
      "Each dataset contains species-level counts along with spatial",
      "coordinates, sampling dates, depth information, and metadata.",
      "",
      "The database is versioned and hosted on Zenodo. Use",
      "get_available_versions() to see all releases and",
      "get_version_metadata() to inspect a specific version.",
      sep = "\n"
    ),

    "package" = paste(
      "forcis R Package Capabilities",
      "==============================",
      "",
      "Beyond the tools exposed in this MCP server, the forcis R package",
      "provides functions for filtering, transforming, and visualizing",
      "FORCIS data. These can be used in R scripts after reading data",
      "with one of the read_*_data() tools.",
      "",
      "Filtering:",
      "- filter_by_ocean(data, ocean): Filter by ocean name.",
      "- filter_by_year(data, years): Filter by sampling year(s).",
      "- filter_by_month(data, months): Filter by sampling month(s).",
      "- filter_by_species(data, species): Keep only selected species.",
      "- filter_by_bbox(data, bbox): Filter by bounding box.",
      "- filter_by_polygon(data, polygon): Filter by spatial polygon.",
      "",
      "Data selection and conversion:",
      "- select_forcis_columns(data): Keep only required columns and taxa.",
      "- select_taxonomy(data, taxonomy): Select a taxonomy (LT, VT, OT).",
      "- convert_to_long_format(data): Pivot species columns to long format.",
      "- get_species_names(data): Extract species names from column names.",
      "",
      "Computation:",
      "- compute_abundances(data): Convert counts to raw abundances.",
      "- compute_concentrations(data): Convert counts to concentrations",
      "  (n specimens/m3).",
      "- compute_frequencies(data): Convert counts to relative abundances.",
      "",
      "Spatial and visualization:",
      "- data_to_sf(data): Convert to sf spatial object.",
      "- plot_record_by_year(data): Barplot of records by year.",
      "- plot_record_by_month(data): Barplot of records by month.",
      "- plot_record_by_season(data): Barplot of records by season.",
      "- plot_record_by_depth(data): Barplot of records by depth (nets only).",
      sep = "\n"
    ),

    "workflow" = paste(
      "Recommended Workflow",
      "=====================",
      "",
      "1. DOWNLOAD the database:",
      "   download_forcis_db(path = 'forcis-db')",
      "",
      "2. READ data for the sampling device of interest:",
      "   read_plankton_nets_data(path = 'forcis-db')",
      "   (or read_cpr_north_data, read_pump_data, etc.)",
      "",
      "3. EXPLORE available species:",
      "   get_species_names() to list all known species.",
      "   get_species_names(taxonomy = 'LT') to list species for a",
      "   specific taxonomy level.",
      "",
      "4. FILTER and SELECT (in R):",
      "   filter_by_ocean(), filter_by_year(), filter_by_species(), etc.",
      "   select_taxonomy() to choose a taxonomic level (LT, VT, OT).",
      "",
      "5. CONVERT (in R):",
      "   convert_to_long_format() to pivot species columns.",
      "",
      "6. COMPUTE (in R):",
      "   compute_abundances(), compute_concentrations(), or",
      "   compute_frequencies() to standardize counts.",
      "",
      "7. VISUALIZE (in R):",
      "   plot_record_by_year(), plot_record_by_month(), etc.",
      "",
      "Steps 1-3 can be performed using MCP tools. Steps 4-7 use",
      "additional forcis R package functions (see 'package' topic).",
      sep = "\n"
    )
  )
}

tool_get_help <- ellmer::tool(
  forcis_mcp_help,
  name = "get_help",
  description = paste(
    "Get documentation and help about the FORCIS MCP server, including",
    "available tools, the FORCIS database, the forcis R package",
    "capabilities, and a recommended analysis workflow. Call with no",
    "arguments for a general overview."
  ),
  arguments = list(
    topic = ellmer::type_enum(
      values = c("overview", "tools", "database", "package", "workflow"),
      description = paste(
        "The help topic to retrieve.",
        "'overview' (default): General introduction to the FORCIS MCP server.",
        "'tools': List all available MCP tools with descriptions.",
        "'database': Learn about the FORCIS database content and structure.",
        "'package': Additional forcis R package capabilities.",
        "'workflow': Recommended step-by-step analysis workflow."
      ),
      required = FALSE
    )
  )
)

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

forcis_mcp_get_species_names <- function(taxonomy = "all") {
  taxa <- forcis:::species_list()
  taxa <- taxa[taxa[["taxonomy"]] != "ZZ", ]

  if (taxonomy != "all") {
    taxa <- taxa[taxa[["taxonomy"]] == taxonomy, ]
  }

  species <- taxa[["taxon"]]

  header <- if (taxonomy == "all") {
    paste0("All species in the FORCIS database (", length(species), " taxa)")
  } else {
    paste0(taxonomy, " taxonomy (", length(species), " taxa)")
  }

  paste(
    c(header, paste0("=", strrep("=", nchar(header))), "", species),
    collapse = "\n"
  )
}

tool_get_species_names <- ellmer::tool(
  forcis_mcp_get_species_names,
  name = "get_species_names",
  description = paste(
    "List all known planktonic foraminifera species (taxa) in the FORCIS",
    "database. Optionally filter by taxonomy level: LT (Lumped Taxonomy,",
    "47 taxa), VT (Validated Taxonomy, 56 taxa), or OT (Original Taxonomy,",
    "203 taxa). Does not require downloading the database. Useful for",
    "discovering valid species names before using filter_by_species()."
  ),
  arguments = list(
    taxonomy = ellmer::type_enum(
      values = c("all", "LT", "VT", "OT"),
      description = paste(
        "The taxonomy level to filter by.",
        "'all' (default): Return all 306 species across all taxonomies.",
        "'LT': Lumped Taxonomy (47 coarser, simplified taxa).",
        "'VT': Validated Taxonomy (56 detailed taxa with subspecies).",
        "'OT': Original Taxonomy (203 taxa preserving original lab names)."
      ),
      required = FALSE
    )
  )
)

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
  tool_get_help,
  tool_get_available_versions,
  tool_get_version_metadata,
  tool_get_ocean_names,
  tool_get_species_names,
  tool_download_forcis_db,
  tool_read_cpr_north_data,
  tool_read_cpr_south_data,
  tool_read_plankton_nets_data,
  tool_read_pump_data,
  tool_read_sediment_trap_data
)
