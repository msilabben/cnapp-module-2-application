package main

config := {
  "max_high": 5,
  "high_threshold": 7.0,
}

high_results[result] {
  run := input.runs[_]
  result := run.results[_]
  rule := run.tool.driver.rules[_]

  rule.id == result.ruleId
  sev := to_number(object.get(rule.properties, "security-severity", "0"))
  sev >= config.high_threshold
}

deny[msg] {
  count(high_results) > config.max_high

  msg := sprintf(
    "Too many HIGH findings: %d (max allowed: %d)",
    [count(high_results), config.max_high],
  )
}