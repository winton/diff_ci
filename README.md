##DiffCi

A service that tests differences between values.

### POST /compare.json

Compare a value with the previously stored baseline value.

If there is no stored baseline value, all tests pass and the **value** becomes the baseline value.

##### Input Object

* **id**
* **tests** - Object that describes how to test difference
  * **additions** - `true` or `false`
  * **removals** - `true` or `false`
  * **sequence** - `true` or `false`
  * **greater_than** - multiplier (i.e. `0.2`)
  * **less_than** - multiplier (i.e. `0.2`)
* **value** - Value for comparison. Can be one of the following:
  * String
  * Number
  * Array of strings
  * Array of numbers

##### Output Object

* **pass** - `true` or `false`
* **additions** - Array of additions
* **removals** - Array of removals
* **sequence** - `true` or `false`
* **difference** - Numeric difference or array of numeric differences

### POST /baseline.json

Update stored baseline value.

##### Input Object

* **id**
* **use_last** - `true` or `false`. Make the value of the last comparison the baseline value
* **value** - Baseline value (if **use_last** not specified)