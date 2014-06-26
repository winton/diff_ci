##DiffCi

A service that tests differences between stored values.

### POST /baseline.json

Update the stored baseline value.

##### Input Object

* **key** - Key for storing baseline value (string)
* **use_last** - `true` or `false`. Make the value of the last comparison the baseline value
* **value** - Baseline value (if **use_last** not specified). Supported data types:
  * String
  * Number
  * Array of strings
  * Array of numbers

### POST /compare.json

Compare a value with the baseline value.

If there is no baseline value, all tests pass and the **value** becomes the baseline value.

##### Input Object

* **key** - Key of baseline value (string)
* **tests** - Object that describes the comparison tests to run
  * **additions** - `true` or `false`
  * **removals** - `true` or `false`
  * **sequence** - `true` or `false`
  * **greater_than** - Multiplier number (i.e. `0.2`)
  * **less_than** - Multiplier number (i.e. `0.2`)
* **value** - Value to compare with baseline


##### Output Object

* **pass** - `true` if all comparisons yielded no difference
* **baseline** - The baseline value
* **additions** - Array of additions
* **removals** - Array of removals
* **sequence** - `false` if comparison value is out of order
* **difference** - Difference in numeric values