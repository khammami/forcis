test_that("forcis_mcp_server() errors when mcptools is not installed", {
  local_mocked_bindings(
    check_installed = function(pkg, ...) {
      if (pkg == "mcptools") {
        rlang::abort(
          paste0("The package '", pkg, "' is required."),
          class = "rlib_error_package_not_found"
        )
      }
    },
    .package = "rlang"
  )

  expect_error(forcis_mcp_server(), class = "rlib_error_package_not_found")
})

test_that("forcis_mcp_server() errors when ellmer is not installed", {
  local_mocked_bindings(
    check_installed = function(pkg, ...) {
      if (pkg == "ellmer") {
        rlang::abort(
          paste0("The package '", pkg, "' is required."),
          class = "rlib_error_package_not_found"
        )
      }
    },
    .package = "rlang"
  )

  expect_error(forcis_mcp_server(), class = "rlib_error_package_not_found")
})

test_that("forcis_mcp_server() calls mcptools::mcp_server() with tools file", {
  called_with <- NULL

  local_mocked_bindings(
    check_installed = function(pkg, ...) invisible(NULL),
    .package = "rlang"
  )
  local_mocked_bindings(
    mcp_server = function(tools, ...) {
      called_with <<- tools
      invisible(NULL)
    },
    .package = "mcptools"
  )

  forcis_mcp_server()

  expect_true(file.exists(called_with))
  expect_match(called_with, "mcp/tools\\.R$")
})

test_that("MCP tools file exists", {
  tools_file <- system.file("mcp", "tools.R", package = "forcis")
  expect_true(nzchar(tools_file))
  expect_true(file.exists(tools_file))
})

test_that("MCP tools file is valid R code", {
  tools_file <- system.file("mcp", "tools.R", package = "forcis")
  expect_no_error(parse(file = tools_file))
})
