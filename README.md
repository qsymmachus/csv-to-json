CSV to JSON
===========

###Usage

Input is a CSV file name, output is a JSON file name:

````ruby
CSVtoJSON.convert_csv(input, output)
````

or in your shell:

````
ruby csv_to_json.rb input.csv output.json
````

Note that if output.json already exists, it will be overwritten.

###Scalar conversion

Scalar types will be automatically converted from strings to their appropriate type:
1. If the words 'true' or 'false' appear as separated values in your CSV file, they will be converted into booleans.
2. '1' will be converted into an integer.
3. '3.14' will be converted into a float.

###Ignoring columns

If a column header is prefixed with a hash/octothorpe (#), it will be excluded from the JSON conversion.

###Example

````
animal,class,diet,#size
frog,amphibian,flies,small
lion,mammal,zebras,big
robin,bird,worms,small
````

will convert to:

````json
[
{
  "animal": "frog",
  "class": "amphibian",
  "diet": "flies"
},
{
  "animal": "lion",
  "class": "mammal",
  "diet": "zebras"
},
{
  "animal": "robin",
  "class": "bird",
  "diet": "worms"
}
]
````