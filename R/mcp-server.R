#' Launch a FORCIS MCP server
#'
#' @description
#' Starts a Model Context Protocol (MCP) server that exposes FORCIS package
#' functions as tools for AI assistants such as Claude Desktop, Claude Code,
#' and VS Code GitHub Copilot.
#'
#' @param ... Additional arguments passed to `mcptools::mcp_server()`.
#'
#' @section Configuration:
#'
#' **Claude Desktop** — paste the following in your Claude Desktop configuration:
#'
#' ```json
#' {
#'   "mcpServers": {
#'     "forcis": {
#'       "command": "Rscript",
#'       "args": ["-e", "forcis::forcis_mcp_server()"]
#'     }
#'   }
#' }
#' ```
#'
#' **Claude Code** — run in a terminal:
#'
#' ```bash
#' claude mcp add -s "user" forcis -- Rscript -e "forcis::forcis_mcp_server()"
#' ```
#'
#' **VS Code** — add to `.vscode/mcp.json`:
#'
#' ```json
#' {
#'   "servers": {
#'     "forcis": {
#'       "command": "Rscript",
#'       "args": ["-e", "forcis::forcis_mcp_server()"]
#'     }
#'   }
#' }
#' ```
#'
#' @return This function does not return. It blocks the current R process to
#'   serve MCP requests.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Start the FORCIS MCP server (blocks the current process)
#' forcis_mcp_server()
#' }

forcis_mcp_server <- function(...) {
  rlang::check_installed("mcptools", reason = "to run the FORCIS MCP server.")
  rlang::check_installed("ellmer", reason = "to define MCP tools.")

  mcptools::mcp_server(
    tools = system.file("mcp", "tools.R", package = "forcis"),
    ...
  )
}
