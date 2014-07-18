##DiffCi

[![Build Status](https://travis-ci.org/winton/diff_ci.svg?branch=master)](https://travis-ci.org/winton/diff_ci)

A service that tests differences between stored values.

### POST /baseline.json

Update the stored baseline value.

##### Input Object

* **key** - Key for storing baseline value (string)
* **value** - Baseline value. Supported data types:
  * String
  * Number
  * Array of strings
  * Array of numbers

##### Output Value

The stored baseline value.

### POST /compare.json

Compare a value with the baseline value.

If there is no baseline value, all tests pass and the **value** becomes the baseline value.

##### Input Object

* **key** - Key of baseline value (string)
* **tests** - Object that describes the comparison tests to run
  * **additions** - `true` or `false`
  * **subtractions** - `true` or `false`
  * **greater_than** - Multiplier number (i.e. `0.2`)
  * **less_than** - Multiplier number (i.e. `0.2`)
* **value** - Value to compare with baseline


##### Output Object

* **pass** - `true` if all comparisons yielded no difference
* **baseline** - The baseline value
* **additions** - Array of additions
* **subtractions** - Array of subtractions
* **difference** - Difference in numeric values