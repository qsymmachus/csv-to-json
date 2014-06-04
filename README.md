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

###Example

````
animal,class,diet
frog,amphibian,flies
lion,mammal,zebras
robin,bird,worms
````

will convert to:

````
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