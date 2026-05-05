package main

config := {
  "max_errors": 1,
  "error_level": "error",
}

error_results[result] {
  run := input.runs[_]
  result := run.results[_]
  rule := run.tool.driver.rules[_]

  rule.id == result.ruleId
  rule.defaultConfiguration.level == config.error_level
}

deny[msg] {
  count(error_results) > config.max_errors

  msg := sprintf(
    "Too many %s findings: %d (max allowed: %d)",
    [config.error_level, count(error_results), config.max_errors],
  )
}