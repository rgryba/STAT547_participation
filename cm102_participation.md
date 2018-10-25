STAT 547 Class Meeting 02 Worksheet
================
Rowenna Gryba
2018-10-25

``` r
suppressPackageStartupMessages(library(tidyverse))
library(gapminder)
library(testthat)
```

    ## 
    ## Attaching package: 'testthat'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     matches

    ## The following object is masked from 'package:purrr':
    ## 
    ##     is_null

Resources
---------

Today's lesson has been drawn from the following resources:

1.  Mostly [stat545.com: character data](http://stat545.com/block028_character-data.html)
    -   See the ["Resources" section](http://stat545.com/block028_character-data.html#resources) for a more comprehensive listing of resources based on the character problem you're facing.
2.  [Older stat545 notes](http://stat545.com/block022_regular-expression.html)
3.  [r4ds: strings](https://r4ds.had.co.nz/strings.html).
4.  [`stringr` vignette](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html)

Basic String Manipulation
-------------------------

**Goal**: Go over some basic functionality of `stringr`.

There's that famous sentence about the quick brown fox that contains all letters of the alphabet, although I don't quite remember the sentence. Demo: Check to see if it's in the `sentences` data. Try:

`str_detect(string, pattern)`
`str_subset(string, pattern)`

``` r
fox <- str_subset(sentences, pattern="fox")
```

Not quite the sentence I was thinking of. How many words does it contain? Use `str_split(string, pattern)`, noting its output (list).

``` r
str_split(fox, pattern=" ")[[1]] %>% length()
```

    ## [1] 8

``` r
str_split(sentences, pattern=" ") %>% head()
```

    ## [[1]]
    ## [1] "The"     "birch"   "canoe"   "slid"    "on"      "the"     "smooth" 
    ## [8] "planks."
    ## 
    ## [[2]]
    ## [1] "Glue"        "the"         "sheet"       "to"          "the"        
    ## [6] "dark"        "blue"        "background."
    ## 
    ## [[3]]
    ## [1] "It's"  "easy"  "to"    "tell"  "the"   "depth" "of"    "a"     "well."
    ## 
    ## [[4]]
    ## [1] "These"   "days"    "a"       "chicken" "leg"     "is"      "a"      
    ## [8] "rare"    "dish."  
    ## 
    ## [[5]]
    ## [1] "Rice"   "is"     "often"  "served" "in"     "round"  "bowls."
    ## 
    ## [[6]]
    ## [1] "The"    "juice"  "of"     "lemons" "makes"  "fine"   "punch."

Exercise: does this sentence contain all letters of the alphabet? Hints:

-   Split by `""`.
-   Consider putting all in lowercase with `str_to_lower()`.
-   Use the base R `table()` function.

``` r
fox %>% 
  str_to_lower() %>%
  str_split(pattern="") %>%  
  `[[`(1) %>%
  table()
```

    ## .
    ##   . a c d e f g h i j k l m n o p q s t u x 
    ## 7 1 1 2 1 5 1 1 2 2 1 1 1 1 2 2 2 1 1 3 2 1

Working in a data frame? `tidyr` has its own version of this. Here's an example from Resource 1, with the fruit data:

``` r
tibble(fruit)
```

    ## # A tibble: 80 x 1
    ##    fruit       
    ##    <chr>       
    ##  1 apple       
    ##  2 apricot     
    ##  3 avocado     
    ##  4 banana      
    ##  5 bell pepper 
    ##  6 bilberry    
    ##  7 blackberry  
    ##  8 blackcurrant
    ##  9 blood orange
    ## 10 blueberry   
    ## # ... with 70 more rows

``` r
tibble(fruit) %>%
  separate(fruit, into = c("pre", "post"), sep = " ")
```

    ## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 69 rows [1,
    ## 2, 3, 4, 6, 7, 8, 10, 11, 12, 14, 15, 16, 18, 19, 20, 21, 22, 23, 24, ...].

    ## # A tibble: 80 x 2
    ##    pre          post  
    ##    <chr>        <chr> 
    ##  1 apple        <NA>  
    ##  2 apricot      <NA>  
    ##  3 avocado      <NA>  
    ##  4 banana       <NA>  
    ##  5 bell         pepper
    ##  6 bilberry     <NA>  
    ##  7 blackberry   <NA>  
    ##  8 blackcurrant <NA>  
    ##  9 blood        orange
    ## 10 blueberry    <NA>  
    ## # ... with 70 more rows

Demo: we can substitute, too. Replace the word "fox" with "giraffe" using `str_replace(string, pattern, replacement)`:

``` r
fox %>% 
    str_replace("fox",replacement = "giraffe")
```

    ## [1] "The quick giraffe jumped on the sleeping cat."

Know the position you want to extract/replace? Try `str_sub()`.

`str_pad()` extends each string to a minimum length:

``` r
fruit %>% head
```

    ## [1] "apple"       "apricot"     "avocado"     "banana"      "bell pepper"
    ## [6] "bilberry"

``` r
fruit %>% 
    str_pad(width=7, side="right", pad="$") %>% 
    head()
```

    ## [1] "apple$$"     "apricot"     "avocado"     "banana$"     "bell pepper"
    ## [6] "bilberry"

`str_length()` (Not the same as `length()`!)

``` r
str_length(fruit)
```

    ##  [1]  5  7  7  6 11  8 10 12 12  9 11 10 12 10  9  6 12 10 10  7  9  8  7
    ## [24]  6  4 11  6  8 10  6  3 10 10  5 10  5  8 11  9  6  6 10  7  5  4  6
    ## [47]  6  9  5  8  9  3  5  6  6  6 12  5  4  9  8  9  4 11  6 17  6  6  8
    ## [70]  9 10 10 11  7 10 10  9  9 10 10

``` r
length(fruit)
```

    ## [1] 80

`str_c()` for concatenating strings. Check the docs for an excellent explanation using a matrix. note: will repeat shorter vectors - line 100

``` r
str_c(words[1:4], words[5:8], sep=" & ")
```

    ## [1] "a & accept"        "able & account"    "about & achieve"  
    ## [4] "absolute & across"

``` r
str_c(words[3:4], words[5:8], sep=" & ")
```

    ## [1] "about & accept"     "absolute & account" "about & achieve"   
    ## [4] "absolute & across"

``` r
str_c(words[3:4], words[5:8], sep=" & ", collapse=", ")
```

    ## [1] "about & accept, absolute & account, about & achieve, absolute & across"

There's a (more limited) `tidyr` version. Straight from Resource 1:

``` r
fruit_df <- tibble(
  fruit1 = fruit[1:4],
  fruit2 = fruit[5:8]
)
fruit_df %>% 
  unite("flavor_combo", fruit1, fruit2, sep = " & ")
```

    ## # A tibble: 4 x 1
    ##   flavor_combo         
    ##   <chr>                
    ## 1 apple & bell pepper  
    ## 2 apricot & bilberry   
    ## 3 avocado & blackberry 
    ## 4 banana & blackcurrant

Exercise: Populate your Participation Repo
------------------------------------------

So, you don't want to manually make 12 folders for your participation repo. I hear you. Let's do that by making a character vector with entries `"cm101"`, `"cm102"`, ..., `"cm112"`.

(If you've already done this, it's still a useful exercise!)

### Make Folders

Let's make those folders!

1.  Make a character vector with entries `"01"`, `"02"`, ..., `12` with `str_pad()`.

``` r
(num <- str_pad(1:12, width=2, side="left", pad="0"))
```

    ##  [1] "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"

1.  Use `str_c()` to combine `"/cm1"` with the numbers:
    -   If your system uses "" instead of "/", you might need two backslashes.

``` r
(folders <- str_c("/cm1", num))
```

    ##  [1] "/cm101" "/cm102" "/cm103" "/cm104" "/cm105" "/cm106" "/cm107"
    ##  [8] "/cm108" "/cm109" "/cm110" "/cm111" "/cm112"

1.  Use `testthat` to check that each entry of `folders` has 6 characters. You might find the base R `all()` function useful.

``` r
test_that("folder names are length 5.", {
    expect_true(all(str_length(folders) == 6))
})
```

1.  BONUS: If applicable, make the folders using `dir.create()`.
    -   Note: `dir.create()` requires the full path to be specified. You might find the `here::here()` function useful.
    -   This code might work (depending on your directory): `for (folder in folders) dir.create(here::here(folder))`
    -   We'll learn how to use `purrr` instead of loops next week.

``` r
for (folder in folders) dir.create(here::here(folder))
```

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm101' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm102' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm103' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm104' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm105' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm106' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm107' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm108' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm109' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm110' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm111' already exists

    ## Warning in dir.create(here::here(folder)): 'C:\Users\rgryba
    ## \Stat545_547\STAT547_participation\\cm112' already exists

### Make README's

Now, let's seed the folders with README's.

1.  Add `/README.md` to the end of the folder names stored in `folders`:

``` r
(files <- str_c(folders, "/README.md"))
```

    ##  [1] "/cm101/README.md" "/cm102/README.md" "/cm103/README.md"
    ##  [4] "/cm104/README.md" "/cm105/README.md" "/cm106/README.md"
    ##  [7] "/cm107/README.md" "/cm108/README.md" "/cm109/README.md"
    ## [10] "/cm110/README.md" "/cm111/README.md" "/cm112/README.md"

1.  Make a vector of contents to put in each README. Put a title and body.
    -   Hint: Use `\n` to indicate a new line! This works in graphs, too.

``` r
(contents <- str_c("# Participation\n\n Participation for class meeting ", 1:12))
```

    ##  [1] "# Participation\n\n Participation for class meeting 1" 
    ##  [2] "# Participation\n\n Participation for class meeting 2" 
    ##  [3] "# Participation\n\n Participation for class meeting 3" 
    ##  [4] "# Participation\n\n Participation for class meeting 4" 
    ##  [5] "# Participation\n\n Participation for class meeting 5" 
    ##  [6] "# Participation\n\n Participation for class meeting 6" 
    ##  [7] "# Participation\n\n Participation for class meeting 7" 
    ##  [8] "# Participation\n\n Participation for class meeting 8" 
    ##  [9] "# Participation\n\n Participation for class meeting 9" 
    ## [10] "# Participation\n\n Participation for class meeting 10"
    ## [11] "# Participation\n\n Participation for class meeting 11"
    ## [12] "# Participation\n\n Participation for class meeting 12"

``` r
cat(contents[1])
```

    ## # Participation
    ## 
    ##  Participation for class meeting 1

1.  BONUS: Write the README's to file using base R's `write(x, file)`:
    -   `for (i in 1:length(files)) write(contents[i], files[i])`
    -   There's a better alternative to a loop using `purrr`. Next week's topic!
    -   This code might not work, depending on your workind directory and system.

``` r
(files <- str_c(here::here(folders), "/READ.md"))
```

    ##  [1] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm101/READ.md"
    ##  [2] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm102/READ.md"
    ##  [3] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm103/READ.md"
    ##  [4] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm104/READ.md"
    ##  [5] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm105/READ.md"
    ##  [6] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm106/READ.md"
    ##  [7] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm107/READ.md"
    ##  [8] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm108/READ.md"
    ##  [9] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm109/READ.md"
    ## [10] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm110/READ.md"
    ## [11] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm111/READ.md"
    ## [12] "C:/Users/rgryba/Stat545_547/STAT547_participation//cm112/READ.md"

``` r
for (i in 1:length(files)) write(contents[i], files[i])
```

Regular Expressions (aka regex)
-------------------------------

Great resource is [r4ds](https://r4ds.had.co.nz/strings.html#matching-patterns-with-regular-expressions)!

Premable:

-   Useful for identifying *patterns*, not exact character specifications.
-   Hard to read and write!
-   We'll focus on finding *matches* (the hardest part). You can also use regex to manipulate strings -- but we'll delegate that to [r4ds: strings: tools](https://r4ds.had.co.nz/strings.html#tools).

Staying true to Resource 1, let's work with the gapminder countries:

``` r
library(gapminder)
countries <- levels(gapminder$country)
```

### The "any character"

Find all countries in the gapminder data set with the following pattern: "i", followed by any single character, followed by "a":

``` r
str_subset(countries, pattern = "i.a")
```

    ##  [1] "Argentina"                "Bosnia and Herzegovina"  
    ##  [3] "Burkina Faso"             "Central African Republic"
    ##  [5] "China"                    "Costa Rica"              
    ##  [7] "Dominican Republic"       "Hong Kong, China"        
    ##  [9] "Jamaica"                  "Mauritania"              
    ## [11] "Nicaragua"                "South Africa"            
    ## [13] "Swaziland"                "Taiwan"                  
    ## [15] "Thailand"                 "Trinidad and Tobago"

Here, `.` stands for "any single character".

But, where's Italy? Case-sensitive!

Let's use `str_view_all()` to see the matches:

``` r
str_view_all(countries, pattern = "i.a")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-de313dd26c5ebab12834">{"x":{"html":"<ul>\n  <li>Afghanistan<\/li>\n  <li>Albania<\/li>\n  <li>Algeria<\/li>\n  <li>Angola<\/li>\n  <li>Argent<span class='match'>ina<\/span><\/li>\n  <li>Australia<\/li>\n  <li>Austria<\/li>\n  <li>Bahrain<\/li>\n  <li>Bangladesh<\/li>\n  <li>Belgium<\/li>\n  <li>Benin<\/li>\n  <li>Bolivia<\/li>\n  <li>Bosnia and Herzegov<span class='match'>ina<\/span><\/li>\n  <li>Botswana<\/li>\n  <li>Brazil<\/li>\n  <li>Bulgaria<\/li>\n  <li>Burk<span class='match'>ina<\/span> Faso<\/li>\n  <li>Burundi<\/li>\n  <li>Cambodia<\/li>\n  <li>Cameroon<\/li>\n  <li>Canada<\/li>\n  <li>Central Afr<span class='match'>ica<\/span>n Republic<\/li>\n  <li>Chad<\/li>\n  <li>Chile<\/li>\n  <li>Ch<span class='match'>ina<\/span><\/li>\n  <li>Colombia<\/li>\n  <li>Comoros<\/li>\n  <li>Congo, Dem. Rep.<\/li>\n  <li>Congo, Rep.<\/li>\n  <li>Costa R<span class='match'>ica<\/span><\/li>\n  <li>Cote d'Ivoire<\/li>\n  <li>Croatia<\/li>\n  <li>Cuba<\/li>\n  <li>Czech Republic<\/li>\n  <li>Denmark<\/li>\n  <li>Djibouti<\/li>\n  <li>Domin<span class='match'>ica<\/span>n Republic<\/li>\n  <li>Ecuador<\/li>\n  <li>Egypt<\/li>\n  <li>El Salvador<\/li>\n  <li>Equatorial Guinea<\/li>\n  <li>Eritrea<\/li>\n  <li>Ethiopia<\/li>\n  <li>Finland<\/li>\n  <li>France<\/li>\n  <li>Gabon<\/li>\n  <li>Gambia<\/li>\n  <li>Germany<\/li>\n  <li>Ghana<\/li>\n  <li>Greece<\/li>\n  <li>Guatemala<\/li>\n  <li>Guinea<\/li>\n  <li>Guinea-Bissau<\/li>\n  <li>Haiti<\/li>\n  <li>Honduras<\/li>\n  <li>Hong Kong, Ch<span class='match'>ina<\/span><\/li>\n  <li>Hungary<\/li>\n  <li>Iceland<\/li>\n  <li>India<\/li>\n  <li>Indonesia<\/li>\n  <li>Iran<\/li>\n  <li>Iraq<\/li>\n  <li>Ireland<\/li>\n  <li>Israel<\/li>\n  <li>Italy<\/li>\n  <li>Jama<span class='match'>ica<\/span><\/li>\n  <li>Japan<\/li>\n  <li>Jordan<\/li>\n  <li>Kenya<\/li>\n  <li>Korea, Dem. Rep.<\/li>\n  <li>Korea, Rep.<\/li>\n  <li>Kuwait<\/li>\n  <li>Lebanon<\/li>\n  <li>Lesotho<\/li>\n  <li>Liberia<\/li>\n  <li>Libya<\/li>\n  <li>Madagascar<\/li>\n  <li>Malawi<\/li>\n  <li>Malaysia<\/li>\n  <li>Mali<\/li>\n  <li>Maur<span class='match'>ita<\/span>nia<\/li>\n  <li>Mauritius<\/li>\n  <li>Mexico<\/li>\n  <li>Mongolia<\/li>\n  <li>Montenegro<\/li>\n  <li>Morocco<\/li>\n  <li>Mozambique<\/li>\n  <li>Myanmar<\/li>\n  <li>Namibia<\/li>\n  <li>Nepal<\/li>\n  <li>Netherlands<\/li>\n  <li>New Zealand<\/li>\n  <li>N<span class='match'>ica<\/span>ragua<\/li>\n  <li>Niger<\/li>\n  <li>Nigeria<\/li>\n  <li>Norway<\/li>\n  <li>Oman<\/li>\n  <li>Pakistan<\/li>\n  <li>Panama<\/li>\n  <li>Paraguay<\/li>\n  <li>Peru<\/li>\n  <li>Philippines<\/li>\n  <li>Poland<\/li>\n  <li>Portugal<\/li>\n  <li>Puerto Rico<\/li>\n  <li>Reunion<\/li>\n  <li>Romania<\/li>\n  <li>Rwanda<\/li>\n  <li>Sao Tome and Principe<\/li>\n  <li>Saudi Arabia<\/li>\n  <li>Senegal<\/li>\n  <li>Serbia<\/li>\n  <li>Sierra Leone<\/li>\n  <li>Singapore<\/li>\n  <li>Slovak Republic<\/li>\n  <li>Slovenia<\/li>\n  <li>Somalia<\/li>\n  <li>South Afr<span class='match'>ica<\/span><\/li>\n  <li>Spain<\/li>\n  <li>Sri Lanka<\/li>\n  <li>Sudan<\/li>\n  <li>Swaz<span class='match'>ila<\/span>nd<\/li>\n  <li>Sweden<\/li>\n  <li>Switzerland<\/li>\n  <li>Syria<\/li>\n  <li>Ta<span class='match'>iwa<\/span>n<\/li>\n  <li>Tanzania<\/li>\n  <li>Tha<span class='match'>ila<\/span>nd<\/li>\n  <li>Togo<\/li>\n  <li>Trin<span class='match'>ida<\/span>d and Tobago<\/li>\n  <li>Tunisia<\/li>\n  <li>Turkey<\/li>\n  <li>Uganda<\/li>\n  <li>United Kingdom<\/li>\n  <li>United States<\/li>\n  <li>Uruguay<\/li>\n  <li>Venezuela<\/li>\n  <li>Vietnam<\/li>\n  <li>West Bank and Gaza<\/li>\n  <li>Yemen, Rep.<\/li>\n  <li>Zambia<\/li>\n  <li>Zimbabwe<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
``` r
str_view_all(countries, pattern = "i.a", match=TRUE)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-e0d616336894c10e6e36">{"x":{"html":"<ul>\n  <li>Argent<span class='match'>ina<\/span><\/li>\n  <li>Bosnia and Herzegov<span class='match'>ina<\/span><\/li>\n  <li>Burk<span class='match'>ina<\/span> Faso<\/li>\n  <li>Central Afr<span class='match'>ica<\/span>n Republic<\/li>\n  <li>Ch<span class='match'>ina<\/span><\/li>\n  <li>Costa R<span class='match'>ica<\/span><\/li>\n  <li>Domin<span class='match'>ica<\/span>n Republic<\/li>\n  <li>Hong Kong, Ch<span class='match'>ina<\/span><\/li>\n  <li>Jama<span class='match'>ica<\/span><\/li>\n  <li>Maur<span class='match'>ita<\/span>nia<\/li>\n  <li>N<span class='match'>ica<\/span>ragua<\/li>\n  <li>South Afr<span class='match'>ica<\/span><\/li>\n  <li>Swaz<span class='match'>ila<\/span>nd<\/li>\n  <li>Ta<span class='match'>iwa<\/span>n<\/li>\n  <li>Tha<span class='match'>ila<\/span>nd<\/li>\n  <li>Trin<span class='match'>ida<\/span>d and Tobago<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Exercise: Canada isn't the only country with three interspersed "a"'s. Find the others. Try both `str_view_all()` and `str_subset()`.

``` r
str_view_all(countries, pattern="a.a.a", match=TRUE)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-4e9fb2aeac709b7cca21">{"x":{"html":"<ul>\n  <li>C<span class='match'>anada<\/span><\/li>\n  <li>M<span class='match'>adaga<\/span>scar<\/li>\n  <li>P<span class='match'>anama<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
``` r
str_subset(countries, pattern="a.a.a")
```

    ## [1] "Canada"     "Madagascar" "Panama"

Let's define a handy function:

``` r
str_view_all_match <- function(countries, pattern) {
    str_view_all(countries, pattern, match=TRUE)
}
str_view_all_match(countries, pattern = "i.a")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-d1d68985872050116ffb">{"x":{"html":"<ul>\n  <li>Argent<span class='match'>ina<\/span><\/li>\n  <li>Bosnia and Herzegov<span class='match'>ina<\/span><\/li>\n  <li>Burk<span class='match'>ina<\/span> Faso<\/li>\n  <li>Central Afr<span class='match'>ica<\/span>n Republic<\/li>\n  <li>Ch<span class='match'>ina<\/span><\/li>\n  <li>Costa R<span class='match'>ica<\/span><\/li>\n  <li>Domin<span class='match'>ica<\/span>n Republic<\/li>\n  <li>Hong Kong, Ch<span class='match'>ina<\/span><\/li>\n  <li>Jama<span class='match'>ica<\/span><\/li>\n  <li>Maur<span class='match'>ita<\/span>nia<\/li>\n  <li>N<span class='match'>ica<\/span>ragua<\/li>\n  <li>South Afr<span class='match'>ica<\/span><\/li>\n  <li>Swaz<span class='match'>ila<\/span>nd<\/li>\n  <li>Ta<span class='match'>iwa<\/span>n<\/li>\n  <li>Tha<span class='match'>ila<\/span>nd<\/li>\n  <li>Trin<span class='match'>ida<\/span>d and Tobago<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
### The escape

What if I wanted to literally search for countries with a period in the name? Escape with `\`, although R requires a double escape.

``` r
str_view_all_match(countries, pattern = "\\.")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-d65bf8fdbc752f2f01e6">{"x":{"html":"<ul>\n  <li>Congo, Dem<span class='match'>.<\/span> Rep<span class='match'>.<\/span><\/li>\n  <li>Congo, Rep<span class='match'>.<\/span><\/li>\n  <li>Korea, Dem<span class='match'>.<\/span> Rep<span class='match'>.<\/span><\/li>\n  <li>Korea, Rep<span class='match'>.<\/span><\/li>\n  <li>Yemen, Rep<span class='match'>.<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Why does R require a double escape? It does one level of escaping before "executing" the regex.

-   See `?Quotes`
-   Try searching for "s. " (without quotes) in this document (don't forget to select "Regex")

### Character Classes

-   `[letters]` matches a single character that's either l, e, t, ..., or s.
-   `[^letters]`: anything *but* these letters.

See more at: <https://r4ds.had.co.nz/strings.html#character-classes-and-alternatives>

Note that not all special characters "work" within `[]`, but some do, and do not always carry the same meaning (like `^`)! From said resource, they are:

> `$` `.` `|` `?` `*` `+` `(` `)` `[` `{`. Unfortunately, a few characters have special meaning even inside a character class and must be handled with backslash escapes: `]` `\` `^` and `-`.

Exercise: Find all countries with three non-vowels next to each other.

``` r
str_view_all_match(countries, pattern = "[^aeiou][^aeiou][^aeiou]")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-99ee240964e76b975643">{"x":{"html":"<ul>\n  <li><span class='match'>Afg<\/span>hanistan<\/li>\n  <li><span class='match'>Alb<\/span>ania<\/li>\n  <li><span class='match'>Alg<\/span>eria<\/li>\n  <li><span class='match'>Ang<\/span>ola<\/li>\n  <li><span class='match'>Arg<\/span>entina<\/li>\n  <li>Au<span class='match'>str<\/span>alia<\/li>\n  <li>Au<span class='match'>str<\/span>ia<\/li>\n  <li>Ba<span class='match'>ngl<\/span>adesh<\/li>\n  <li>Bosnia a<span class='match'>nd <\/span>Herzegovina<\/li>\n  <li>Bo<span class='match'>tsw<\/span>ana<\/li>\n  <li>Ce<span class='match'>ntr<\/span>a<span class='match'>l A<\/span>frica<span class='match'>n R<\/span>epublic<\/li>\n  <li>Congo<span class='match'>, D<\/span>e<span class='match'>m. <\/span>Rep.<\/li>\n  <li>Congo<span class='match'>, R<\/span>ep.<\/li>\n  <li>Cote<span class='match'> d'<\/span>Ivoire<\/li>\n  <li>Cze<span class='match'>ch <\/span>Republic<\/li>\n  <li>Dominica<span class='match'>n R<\/span>epublic<\/li>\n  <li><span class='match'>Egy<\/span>pt<\/li>\n  <li><span class='match'>El <\/span>Salvador<\/li>\n  <li>Equatoria<span class='match'>l G<\/span>uinea<\/li>\n  <li><span class='match'>Eth<\/span>iopia<\/li>\n  <li>Ho<span class='match'>ng <\/span>Ko<span class='match'>ng,<\/span><span class='match'> Ch<\/span>ina<\/li>\n  <li><span class='match'>Ind<\/span>ia<\/li>\n  <li><span class='match'>Ind<\/span>onesia<\/li>\n  <li><span class='match'>Isr<\/span>ael<\/li>\n  <li>Korea<span class='match'>, D<\/span>e<span class='match'>m. <\/span>Rep.<\/li>\n  <li>Korea<span class='match'>, R<\/span>ep.<\/li>\n  <li>Netherla<span class='match'>nds<\/span><\/li>\n  <li>Ne<span class='match'>w Z<\/span>ealand<\/li>\n  <li>Sao Tome a<span class='match'>nd <\/span>Principe<\/li>\n  <li>Saudi<span class='match'> Ar<\/span>abia<\/li>\n  <li>Slova<span class='match'>k R<\/span>epublic<\/li>\n  <li>Sou<span class='match'>th <\/span><span class='match'>Afr<\/span>ica<\/li>\n  <li><span class='match'>Syr<\/span>ia<\/li>\n  <li>Trinidad a<span class='match'>nd <\/span>Tobago<\/li>\n  <li>Unite<span class='match'>d K<\/span>i<span class='match'>ngd<\/span>om<\/li>\n  <li>Unite<span class='match'>d S<\/span>tates<\/li>\n  <li>We<span class='match'>st <\/span>Ba<span class='match'>nk <\/span>a<span class='match'>nd <\/span>Gaza<\/li>\n  <li>Yeme<span class='match'>n, <\/span>Rep.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
### Or

-   Use `|` to denote "or".
-   "And" is implied otherwise, and has precedence.
-   Use parentheses to indicate precedence.

Beer or bear?

``` r
c("bear", "beer", "bar") %>% 
    str_view_all_match(pattern = "be(e|a)r")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-5965c3f1eda48bd0fd5e">{"x":{"html":"<ul>\n  <li><span class='match'>bear<\/span><\/li>\n  <li><span class='match'>beer<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
### Quantifiers/Repetition

The handy ones are:

-   `*` for 0 or more
-   `+` for 1 or more
-   `?` for 0 or 1

See list at <https://r4ds.had.co.nz/strings.html#repetition>

Find all countries that have any number of o's (but at least 1) following r:

``` r
str_view_all_match(countries, "ro+")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-f4f9b32fd31f3f56acc5">{"x":{"html":"<ul>\n  <li>Came<span class='match'>roo<\/span>n<\/li>\n  <li>Como<span class='match'>ro<\/span>s<\/li>\n  <li>C<span class='match'>ro<\/span>atia<\/li>\n  <li>Monteneg<span class='match'>ro<\/span><\/li>\n  <li>Mo<span class='match'>ro<\/span>cco<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Find all countries that have exactly two e's next two each other:

``` r
str_view_all_match(countries, "e{2}")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-51f7a7382af666343fc6">{"x":{"html":"<ul>\n  <li>Gr<span class='match'>ee<\/span>ce<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Exercise: Find all countries that have either "a" or "e", twice in a row (with a changeover allowed, such as "ae" or "ea"):

``` r
str_view_all_match(countries, pattern="e{2}|a{2}|ae|ea")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-562511658a09894cf489">{"x":{"html":"<ul>\n  <li>Equatorial Guin<span class='match'>ea<\/span><\/li>\n  <li>Eritr<span class='match'>ea<\/span><\/li>\n  <li>Gr<span class='match'>ee<\/span>ce<\/li>\n  <li>Guin<span class='match'>ea<\/span><\/li>\n  <li>Guin<span class='match'>ea<\/span>-Bissau<\/li>\n  <li>Isr<span class='match'>ae<\/span>l<\/li>\n  <li>Kor<span class='match'>ea<\/span>, Dem. Rep.<\/li>\n  <li>Kor<span class='match'>ea<\/span>, Rep.<\/li>\n  <li>New Z<span class='match'>ea<\/span>land<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
``` r
str_view_all_match(countries, pattern="(a|e)(a|e)")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-b4075ed1ee7c046d91e9">{"x":{"html":"<ul>\n  <li>Equatorial Guin<span class='match'>ea<\/span><\/li>\n  <li>Eritr<span class='match'>ea<\/span><\/li>\n  <li>Gr<span class='match'>ee<\/span>ce<\/li>\n  <li>Guin<span class='match'>ea<\/span><\/li>\n  <li>Guin<span class='match'>ea<\/span>-Bissau<\/li>\n  <li>Isr<span class='match'>ae<\/span>l<\/li>\n  <li>Kor<span class='match'>ea<\/span>, Dem. Rep.<\/li>\n  <li>Kor<span class='match'>ea<\/span>, Rep.<\/li>\n  <li>New Z<span class='match'>ea<\/span>land<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
``` r
str_view_all_match(countries, pattern="(a|e){2}")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-543f10cec534dedec21b">{"x":{"html":"<ul>\n  <li>Equatorial Guin<span class='match'>ea<\/span><\/li>\n  <li>Eritr<span class='match'>ea<\/span><\/li>\n  <li>Gr<span class='match'>ee<\/span>ce<\/li>\n  <li>Guin<span class='match'>ea<\/span><\/li>\n  <li>Guin<span class='match'>ea<\/span>-Bissau<\/li>\n  <li>Isr<span class='match'>ae<\/span>l<\/li>\n  <li>Kor<span class='match'>ea<\/span>, Dem. Rep.<\/li>\n  <li>Kor<span class='match'>ea<\/span>, Rep.<\/li>\n  <li>New Z<span class='match'>ea<\/span>land<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
### Position indicators

-   `^` corresponds to the **beginning** of the line.
-   `$` corresponds to the **end** of the line.

Countries that end in "land":

``` r
str_view_all_match(countries, pattern = "land$")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-5e3ac67c43a896e98386">{"x":{"html":"<ul>\n  <li>Fin<span class='match'>land<\/span><\/li>\n  <li>Ice<span class='match'>land<\/span><\/li>\n  <li>Ire<span class='match'>land<\/span><\/li>\n  <li>New Zea<span class='match'>land<\/span><\/li>\n  <li>Po<span class='match'>land<\/span><\/li>\n  <li>Swazi<span class='match'>land<\/span><\/li>\n  <li>Switzer<span class='match'>land<\/span><\/li>\n  <li>Thai<span class='match'>land<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
``` r
str_view_all_match(countries, pattern = "$")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-6f5fa19ad0c029eadf19">{"x":{"html":"<ul>\n  <li>Afghanistan<span class='match'><\/span><\/li>\n  <li>Albania<span class='match'><\/span><\/li>\n  <li>Algeria<span class='match'><\/span><\/li>\n  <li>Angola<span class='match'><\/span><\/li>\n  <li>Argentina<span class='match'><\/span><\/li>\n  <li>Australia<span class='match'><\/span><\/li>\n  <li>Austria<span class='match'><\/span><\/li>\n  <li>Bahrain<span class='match'><\/span><\/li>\n  <li>Bangladesh<span class='match'><\/span><\/li>\n  <li>Belgium<span class='match'><\/span><\/li>\n  <li>Benin<span class='match'><\/span><\/li>\n  <li>Bolivia<span class='match'><\/span><\/li>\n  <li>Bosnia and Herzegovina<span class='match'><\/span><\/li>\n  <li>Botswana<span class='match'><\/span><\/li>\n  <li>Brazil<span class='match'><\/span><\/li>\n  <li>Bulgaria<span class='match'><\/span><\/li>\n  <li>Burkina Faso<span class='match'><\/span><\/li>\n  <li>Burundi<span class='match'><\/span><\/li>\n  <li>Cambodia<span class='match'><\/span><\/li>\n  <li>Cameroon<span class='match'><\/span><\/li>\n  <li>Canada<span class='match'><\/span><\/li>\n  <li>Central African Republic<span class='match'><\/span><\/li>\n  <li>Chad<span class='match'><\/span><\/li>\n  <li>Chile<span class='match'><\/span><\/li>\n  <li>China<span class='match'><\/span><\/li>\n  <li>Colombia<span class='match'><\/span><\/li>\n  <li>Comoros<span class='match'><\/span><\/li>\n  <li>Congo, Dem. Rep.<span class='match'><\/span><\/li>\n  <li>Congo, Rep.<span class='match'><\/span><\/li>\n  <li>Costa Rica<span class='match'><\/span><\/li>\n  <li>Cote d'Ivoire<span class='match'><\/span><\/li>\n  <li>Croatia<span class='match'><\/span><\/li>\n  <li>Cuba<span class='match'><\/span><\/li>\n  <li>Czech Republic<span class='match'><\/span><\/li>\n  <li>Denmark<span class='match'><\/span><\/li>\n  <li>Djibouti<span class='match'><\/span><\/li>\n  <li>Dominican Republic<span class='match'><\/span><\/li>\n  <li>Ecuador<span class='match'><\/span><\/li>\n  <li>Egypt<span class='match'><\/span><\/li>\n  <li>El Salvador<span class='match'><\/span><\/li>\n  <li>Equatorial Guinea<span class='match'><\/span><\/li>\n  <li>Eritrea<span class='match'><\/span><\/li>\n  <li>Ethiopia<span class='match'><\/span><\/li>\n  <li>Finland<span class='match'><\/span><\/li>\n  <li>France<span class='match'><\/span><\/li>\n  <li>Gabon<span class='match'><\/span><\/li>\n  <li>Gambia<span class='match'><\/span><\/li>\n  <li>Germany<span class='match'><\/span><\/li>\n  <li>Ghana<span class='match'><\/span><\/li>\n  <li>Greece<span class='match'><\/span><\/li>\n  <li>Guatemala<span class='match'><\/span><\/li>\n  <li>Guinea<span class='match'><\/span><\/li>\n  <li>Guinea-Bissau<span class='match'><\/span><\/li>\n  <li>Haiti<span class='match'><\/span><\/li>\n  <li>Honduras<span class='match'><\/span><\/li>\n  <li>Hong Kong, China<span class='match'><\/span><\/li>\n  <li>Hungary<span class='match'><\/span><\/li>\n  <li>Iceland<span class='match'><\/span><\/li>\n  <li>India<span class='match'><\/span><\/li>\n  <li>Indonesia<span class='match'><\/span><\/li>\n  <li>Iran<span class='match'><\/span><\/li>\n  <li>Iraq<span class='match'><\/span><\/li>\n  <li>Ireland<span class='match'><\/span><\/li>\n  <li>Israel<span class='match'><\/span><\/li>\n  <li>Italy<span class='match'><\/span><\/li>\n  <li>Jamaica<span class='match'><\/span><\/li>\n  <li>Japan<span class='match'><\/span><\/li>\n  <li>Jordan<span class='match'><\/span><\/li>\n  <li>Kenya<span class='match'><\/span><\/li>\n  <li>Korea, Dem. Rep.<span class='match'><\/span><\/li>\n  <li>Korea, Rep.<span class='match'><\/span><\/li>\n  <li>Kuwait<span class='match'><\/span><\/li>\n  <li>Lebanon<span class='match'><\/span><\/li>\n  <li>Lesotho<span class='match'><\/span><\/li>\n  <li>Liberia<span class='match'><\/span><\/li>\n  <li>Libya<span class='match'><\/span><\/li>\n  <li>Madagascar<span class='match'><\/span><\/li>\n  <li>Malawi<span class='match'><\/span><\/li>\n  <li>Malaysia<span class='match'><\/span><\/li>\n  <li>Mali<span class='match'><\/span><\/li>\n  <li>Mauritania<span class='match'><\/span><\/li>\n  <li>Mauritius<span class='match'><\/span><\/li>\n  <li>Mexico<span class='match'><\/span><\/li>\n  <li>Mongolia<span class='match'><\/span><\/li>\n  <li>Montenegro<span class='match'><\/span><\/li>\n  <li>Morocco<span class='match'><\/span><\/li>\n  <li>Mozambique<span class='match'><\/span><\/li>\n  <li>Myanmar<span class='match'><\/span><\/li>\n  <li>Namibia<span class='match'><\/span><\/li>\n  <li>Nepal<span class='match'><\/span><\/li>\n  <li>Netherlands<span class='match'><\/span><\/li>\n  <li>New Zealand<span class='match'><\/span><\/li>\n  <li>Nicaragua<span class='match'><\/span><\/li>\n  <li>Niger<span class='match'><\/span><\/li>\n  <li>Nigeria<span class='match'><\/span><\/li>\n  <li>Norway<span class='match'><\/span><\/li>\n  <li>Oman<span class='match'><\/span><\/li>\n  <li>Pakistan<span class='match'><\/span><\/li>\n  <li>Panama<span class='match'><\/span><\/li>\n  <li>Paraguay<span class='match'><\/span><\/li>\n  <li>Peru<span class='match'><\/span><\/li>\n  <li>Philippines<span class='match'><\/span><\/li>\n  <li>Poland<span class='match'><\/span><\/li>\n  <li>Portugal<span class='match'><\/span><\/li>\n  <li>Puerto Rico<span class='match'><\/span><\/li>\n  <li>Reunion<span class='match'><\/span><\/li>\n  <li>Romania<span class='match'><\/span><\/li>\n  <li>Rwanda<span class='match'><\/span><\/li>\n  <li>Sao Tome and Principe<span class='match'><\/span><\/li>\n  <li>Saudi Arabia<span class='match'><\/span><\/li>\n  <li>Senegal<span class='match'><\/span><\/li>\n  <li>Serbia<span class='match'><\/span><\/li>\n  <li>Sierra Leone<span class='match'><\/span><\/li>\n  <li>Singapore<span class='match'><\/span><\/li>\n  <li>Slovak Republic<span class='match'><\/span><\/li>\n  <li>Slovenia<span class='match'><\/span><\/li>\n  <li>Somalia<span class='match'><\/span><\/li>\n  <li>South Africa<span class='match'><\/span><\/li>\n  <li>Spain<span class='match'><\/span><\/li>\n  <li>Sri Lanka<span class='match'><\/span><\/li>\n  <li>Sudan<span class='match'><\/span><\/li>\n  <li>Swaziland<span class='match'><\/span><\/li>\n  <li>Sweden<span class='match'><\/span><\/li>\n  <li>Switzerland<span class='match'><\/span><\/li>\n  <li>Syria<span class='match'><\/span><\/li>\n  <li>Taiwan<span class='match'><\/span><\/li>\n  <li>Tanzania<span class='match'><\/span><\/li>\n  <li>Thailand<span class='match'><\/span><\/li>\n  <li>Togo<span class='match'><\/span><\/li>\n  <li>Trinidad and Tobago<span class='match'><\/span><\/li>\n  <li>Tunisia<span class='match'><\/span><\/li>\n  <li>Turkey<span class='match'><\/span><\/li>\n  <li>Uganda<span class='match'><\/span><\/li>\n  <li>United Kingdom<span class='match'><\/span><\/li>\n  <li>United States<span class='match'><\/span><\/li>\n  <li>Uruguay<span class='match'><\/span><\/li>\n  <li>Venezuela<span class='match'><\/span><\/li>\n  <li>Vietnam<span class='match'><\/span><\/li>\n  <li>West Bank and Gaza<span class='match'><\/span><\/li>\n  <li>Yemen, Rep.<span class='match'><\/span><\/li>\n  <li>Zambia<span class='match'><\/span><\/li>\n  <li>Zimbabwe<span class='match'><\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Countries that start with "Ca":

``` r
str_view_all_match(countries, pattern = "^Ca")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-1cac82209f6b703402bf">{"x":{"html":"<ul>\n  <li><span class='match'>Ca<\/span>mbodia<\/li>\n  <li><span class='match'>Ca<\/span>meroon<\/li>\n  <li><span class='match'>Ca<\/span>nada<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Countries without a vowel? The word should start with a non-vowel, continue as a non-vowel, and end:

``` r
str_view_all_match(countries, "^[^aeiouAEIOU]*$")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-9e313fda6803316d6d4c">{"x":{"html":"<ul>\n  <li><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
### Groups

We can refer to parentheses groups:

``` r
str_view_all(c("abad", "abbd"), pattern="(a)(b)\\1")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-3f75dd0df8209436350b">{"x":{"html":"<ul>\n  <li><span class='match'>aba<\/span>d<\/li>\n  <li>abbd<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
``` r
str_view_all(c("abad", "abbd"), pattern="(a)(b)\\2")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-e43b6c076c613ce41ce4">{"x":{"html":"<ul>\n  <li>abad<\/li>\n  <li><span class='match'>abb<\/span>d<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Note that the parentheses are first resolved, THEN referred to. NOT re-executed.

``` r
str_view_all(c("bananas"), "(.)(.)\\1\\2.*\\1\\2")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-2a3117f443d875d3e3da">{"x":{"html":"<ul>\n  <li>bananas<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
'b' not highlighted because 'ba' is never followed again by another 'ba'; moves to 'an'

We can refer to them later in the search, too:

``` r
str_view_all(c("bananas", "Who can? Bananas can."), "(.)(.)\\1\\2.*\\1\\2")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-1d2765688dcdd8ab0d7f">{"x":{"html":"<ul>\n  <li>bananas<\/li>\n  <li>Who can? B<span class='match'>ananas can<\/span>.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Final Exercises
---------------

Convert `words` to pig latin, which involves:

1.  Make the first letter the last letter
    -   Get the first letter with `str_sub(string, start, end)`.
2.  Remove the first letter from `words`.
    -   Hint: leave the `end` argument blank.
3.  Add "ay" to the end of the word.
    -   Use `str_c()`.

``` r
head(words)
```

    ## [1] "a"        "able"     "about"    "absolute" "accept"   "account"

``` r
words %>%
  str_c(., str_sub(., 1, 1)) %>%
  str_sub(start=2) %>%
  str_c(., "ay")
```

    ##   [1] "aay"           "bleaay"        "boutaay"       "bsoluteaay"   
    ##   [5] "cceptaay"      "ccountaay"     "chieveaay"     "crossaay"     
    ##   [9] "ctaay"         "ctiveaay"      "ctualaay"      "ddaay"        
    ##  [13] "ddressaay"     "dmitaay"       "dvertiseaay"   "ffectaay"     
    ##  [17] "ffordaay"      "fteraay"       "fternoonaay"   "gainaay"      
    ##  [21] "gainstaay"     "geaay"         "gentaay"       "goaay"        
    ##  [25] "greeaay"       "iraay"         "llaay"         "llowaay"      
    ##  [29] "lmostaay"      "longaay"       "lreadyaay"     "lrightaay"    
    ##  [33] "lsoaay"        "lthoughaay"    "lwaysaay"      "mericaaay"    
    ##  [37] "mountaay"      "ndaay"         "notheraay"     "nsweraay"     
    ##  [41] "nyaay"         "partaay"       "pparentaay"    "ppearaay"     
    ##  [45] "pplyaay"       "ppointaay"     "pproachaay"    "ppropriateaay"
    ##  [49] "reaaay"        "rgueaay"       "rmaay"         "roundaay"     
    ##  [53] "rrangeaay"     "rtaay"         "saay"          "skaay"        
    ##  [57] "ssociateaay"   "ssumeaay"      "taay"          "ttendaay"     
    ##  [61] "uthorityaay"   "vailableaay"   "wareaay"       "wayaay"       
    ##  [65] "wfulaay"       "abybay"        "ackbay"        "adbay"        
    ##  [69] "agbay"         "alancebay"     "allbay"        "ankbay"       
    ##  [73] "arbay"         "asebay"        "asisbay"       "ebay"         
    ##  [77] "earbay"        "eatbay"        "eautybay"      "ecausebay"    
    ##  [81] "ecomebay"      "edbay"         "eforebay"      "eginbay"      
    ##  [85] "ehindbay"      "elievebay"     "enefitbay"     "estbay"       
    ##  [89] "etbay"         "etweenbay"     "igbay"         "illbay"       
    ##  [93] "irthbay"       "itbay"         "lackbay"       "lokebay"      
    ##  [97] "loodbay"       "lowbay"        "luebay"        "oardbay"      
    ## [101] "oatbay"        "odybay"        "ookbay"        "othbay"       
    ## [105] "otherbay"      "ottlebay"      "ottombay"      "oxbay"        
    ## [109] "oybay"         "reakbay"       "riefbay"       "rilliantbay"  
    ## [113] "ringbay"       "ritainbay"     "rotherbay"     "udgetbay"     
    ## [117] "uildbay"       "usbay"         "usinessbay"    "usybay"       
    ## [121] "utbay"         "uybay"         "ybay"          "akecay"       
    ## [125] "allcay"        "ancay"         "arcay"         "ardcay"       
    ## [129] "arecay"        "arrycay"       "asecay"        "atcay"        
    ## [133] "atchcay"       "ausecay"       "entcay"        "entrecay"     
    ## [137] "ertaincay"     "haircay"       "hairmancay"    "hancecay"     
    ## [141] "hangecay"      "hapcay"        "haractercay"   "hargecay"     
    ## [145] "heapcay"       "heckcay"       "hildcay"       "hoicecay"     
    ## [149] "hoosecay"      "hristCay"      "hristmasCay"   "hurchcay"     
    ## [153] "itycay"        "laimcay"       "lasscay"       "leancay"      
    ## [157] "learcay"       "lientcay"      "lockcay"       "losecay"      
    ## [161] "losescay"      "lothecay"      "lubcay"        "offeecay"     
    ## [165] "oldcay"        "olleaguecay"   "ollectcay"     "ollegecay"    
    ## [169] "olourcay"      "omecay"        "ommentcay"     "ommitcay"     
    ## [173] "ommitteecay"   "ommoncay"      "ommunitycay"   "ompanycay"    
    ## [177] "omparecay"     "ompletecay"    "omputecay"     "oncerncay"    
    ## [181] "onditioncay"   "onfercay"      "onsidercay"    "onsultcay"    
    ## [185] "ontactcay"     "ontinuecay"    "ontractcay"    "ontrolcay"    
    ## [189] "onversecay"    "ookcay"        "opycay"        "ornercay"     
    ## [193] "orrectcay"     "ostcay"        "ouldcay"       "ouncilcay"    
    ## [197] "ountcay"       "ountrycay"     "ountycay"      "ouplecay"     
    ## [201] "oursecay"      "ourtcay"       "overcay"       "reatecay"     
    ## [205] "rosscay"       "upcay"         "urrentcay"     "utcay"        
    ## [209] "adday"         "angerday"      "ateday"        "ayday"        
    ## [213] "eadday"        "ealday"        "earday"        "ebateday"     
    ## [217] "ecideday"      "ecisionday"    "eepday"        "efiniteday"   
    ## [221] "egreeday"      "epartmentday"  "ependday"      "escribeday"   
    ## [225] "esignday"      "etailday"      "evelopday"     "ieday"        
    ## [229] "ifferenceday"  "ifficultday"   "innerday"      "irectday"     
    ## [233] "iscussday"     "istrictday"    "ivideday"      "oday"         
    ## [237] "octorday"      "ocumentday"    "ogday"         "oorday"       
    ## [241] "oubleday"      "oubtday"       "ownday"        "rawday"       
    ## [245] "ressday"       "rinkday"       "riveday"       "ropday"       
    ## [249] "ryday"         "ueday"         "uringday"      "acheay"       
    ## [253] "arlyeay"       "asteay"        "asyeay"        "ateay"        
    ## [257] "conomyeay"     "ducateeay"     "ffecteay"      "ggeay"        
    ## [261] "ighteay"       "ithereay"      "lecteay"       "lectriceay"   
    ## [265] "leveneay"      "lseeay"        "mployeay"      "ncourageeay"  
    ## [269] "ndeay"         "ngineeay"      "nglisheay"     "njoyeay"      
    ## [273] "nougheay"      "ntereay"       "nvironmenteay" "qualeay"      
    ## [277] "specialeay"    "uropeeay"      "veneay"        "veningeay"    
    ## [281] "vereay"        "veryeay"       "videnceeay"    "xacteay"      
    ## [285] "xampleeay"     "xcepteay"      "xcuseeay"      "xerciseeay"   
    ## [289] "xisteay"       "xpecteay"      "xpenseeay"     "xperienceeay" 
    ## [293] "xplaineay"     "xpresseay"     "xtraeay"       "yeeay"        
    ## [297] "acefay"        "actfay"        "airfay"        "allfay"       
    ## [301] "amilyfay"      "arfay"         "armfay"        "astfay"       
    ## [305] "atherfay"      "avourfay"      "eedfay"        "eelfay"       
    ## [309] "ewfay"         "ieldfay"       "ightfay"       "igurefay"     
    ## [313] "ilefay"        "illfay"        "ilmfay"        "inalfay"      
    ## [317] "inancefay"     "indfay"        "inefay"        "inishfay"     
    ## [321] "irefay"        "irstfay"       "ishfay"        "itfay"        
    ## [325] "ivefay"        "latfay"        "loorfay"       "lyfay"        
    ## [329] "ollowfay"      "oodfay"        "ootfay"        "orfay"        
    ## [333] "orcefay"       "orgetfay"      "ormfay"        "ortunefay"    
    ## [337] "orwardfay"     "ourfay"        "rancefay"      "reefay"       
    ## [341] "ridayfay"      "riendfay"      "romfay"        "rontfay"      
    ## [345] "ullfay"        "unfay"         "unctionfay"    "undfay"       
    ## [349] "urtherfay"     "uturefay"      "amegay"        "ardengay"     
    ## [353] "asgay"         "eneralgay"     "ermanygay"     "etgay"        
    ## [357] "irlgay"        "ivegay"        "lassgay"       "ogay"         
    ## [361] "odgay"         "oodgay"        "oodbyegay"     "overngay"     
    ## [365] "randgay"       "rantgay"       "reatgay"       "reengay"      
    ## [369] "roundgay"      "roupgay"       "rowgay"        "uessgay"      
    ## [373] "uygay"         "airhay"        "alfhay"        "allhay"       
    ## [377] "andhay"        "anghay"        "appenhay"      "appyhay"      
    ## [381] "ardhay"        "atehay"        "avehay"        "ehay"         
    ## [385] "eadhay"        "ealthhay"      "earhay"        "earthay"      
    ## [389] "eathay"        "eavyhay"       "ellhay"        "elphay"       
    ## [393] "erehay"        "ighhay"        "istoryhay"     "ithay"        
    ## [397] "oldhay"        "olidayhay"     "omehay"        "onesthay"     
    ## [401] "opehay"        "orsehay"       "ospitalhay"    "othay"        
    ## [405] "ourhay"        "ousehay"       "owhay"         "oweverhay"    
    ## [409] "ullohay"       "undredhay"     "usbandhay"     "deaiay"       
    ## [413] "dentifyiay"    "fiay"          "magineiay"     "mportantiay"  
    ## [417] "mproveiay"     "niay"          "ncludeiay"     "ncomeiay"     
    ## [421] "ncreaseiay"    "ndeediay"      "ndividualiay"  "ndustryiay"   
    ## [425] "nformiay"      "nsideiay"      "nsteadiay"     "nsureiay"     
    ## [429] "nterestiay"    "ntoiay"        "ntroduceiay"   "nvestiay"     
    ## [433] "nvolveiay"     "ssueiay"       "tiay"          "temiay"       
    ## [437] "esusjay"       "objay"         "oinjay"        "udgejay"      
    ## [441] "umpjay"        "ustjay"        "eepkay"        "eykay"        
    ## [445] "idkay"         "illkay"        "indkay"        "ingkay"       
    ## [449] "itchenkay"     "nockkay"       "nowkay"        "abourlay"     
    ## [453] "adlay"         "adylay"        "andlay"        "anguagelay"   
    ## [457] "argelay"       "astlay"        "atelay"        "aughlay"      
    ## [461] "awlay"         "aylay"         "eadlay"        "earnlay"      
    ## [465] "eavelay"       "eftlay"        "eglay"         "esslay"       
    ## [469] "etlay"         "etterlay"      "evellay"       "ielay"        
    ## [473] "ifelay"        "ightlay"       "ikelay"        "ikelylay"     
    ## [477] "imitlay"       "inelay"        "inklay"        "istlay"       
    ## [481] "istenlay"      "ittlelay"      "ivelay"        "oadlay"       
    ## [485] "ocallay"       "ocklay"        "ondonlay"      "onglay"       
    ## [489] "ooklay"        "ordlay"        "oselay"        "otlay"        
    ## [493] "ovelay"        "owlay"         "ucklay"        "unchlay"      
    ## [497] "achinemay"     "ainmay"        "ajormay"       "akemay"       
    ## [501] "anmay"         "anagemay"      "anymay"        "arkmay"       
    ## [505] "arketmay"      "arrymay"       "atchmay"       "attermay"     
    ## [509] "aymay"         "aybemay"       "eanmay"        "eaningmay"    
    ## [513] "easuremay"     "eetmay"        "embermay"      "entionmay"    
    ## [517] "iddlemay"      "ightmay"       "ilemay"        "ilkmay"       
    ## [521] "illionmay"     "indmay"        "inistermay"    "inusmay"      
    ## [525] "inutemay"      "issmay"        "istermay"      "omentmay"     
    ## [529] "ondaymay"      "oneymay"       "onthmay"       "oremay"       
    ## [533] "orningmay"     "ostmay"        "othermay"      "otionmay"     
    ## [537] "ovemay"        "rsmay"         "uchmay"        "usicmay"      
    ## [541] "ustmay"        "amenay"        "ationnay"      "aturenay"     
    ## [545] "earnay"        "ecessarynay"   "eednay"        "evernay"      
    ## [549] "ewnay"         "ewsnay"        "extnay"        "icenay"       
    ## [553] "ightnay"       "inenay"        "onay"          "onnay"        
    ## [557] "onenay"        "ormalnay"      "orthnay"       "otnay"        
    ## [561] "otenay"        "oticenay"      "ownay"         "umbernay"     
    ## [565] "bviousoay"     "ccasionoay"    "ddoay"         "foay"         
    ## [569] "ffoay"         "fferoay"       "fficeoay"      "ftenoay"      
    ## [573] "kayoay"        "ldoay"         "noay"          "nceoay"       
    ## [577] "neoay"         "nlyoay"        "penoay"        "perateoay"    
    ## [581] "pportunityoay" "pposeoay"      "roay"          "rderoay"      
    ## [585] "rganizeoay"    "riginaloay"    "theroay"       "therwiseoay"  
    ## [589] "ughtoay"       "utoay"         "veroay"        "wnoay"        
    ## [593] "ackpay"        "agepay"        "aintpay"       "airpay"       
    ## [597] "aperpay"       "aragraphpay"   "ardonpay"      "arentpay"     
    ## [601] "arkpay"        "artpay"        "articularpay"  "artypay"      
    ## [605] "asspay"        "astpay"        "aypay"         "encepay"      
    ## [609] "ensionpay"     "eoplepay"      "erpay"         "ercentpay"    
    ## [613] "erfectpay"     "erhapspay"     "eriodpay"      "ersonpay"     
    ## [617] "hotographpay"  "ickpay"        "icturepay"     "iecepay"      
    ## [621] "lacepay"       "lanpay"        "laypay"        "leasepay"     
    ## [625] "luspay"        "ointpay"       "olicepay"      "olicypay"     
    ## [629] "oliticpay"     "oorpay"        "ositionpay"    "ositivepay"   
    ## [633] "ossiblepay"    "ostpay"        "oundpay"       "owerpay"      
    ## [637] "ractisepay"    "reparepay"     "resentpay"     "resspay"      
    ## [641] "ressurepay"    "resumepay"     "rettypay"      "reviouspay"   
    ## [645] "ricepay"       "rintpay"       "rivatepay"     "robablepay"   
    ## [649] "roblempay"     "roceedpay"     "rocesspay"     "roducepay"    
    ## [653] "roductpay"     "rogrammepay"   "rojectpay"     "roperpay"     
    ## [657] "roposepay"     "rotectpay"     "rovidepay"     "ublicpay"     
    ## [661] "ullpay"        "urposepay"     "ushpay"        "utpay"        
    ## [665] "ualityqay"     "uarterqay"     "uestionqay"    "uickqay"      
    ## [669] "uidqay"        "uietqay"       "uiteqay"       "adioray"      
    ## [673] "ailray"        "aiseray"       "angeray"       "ateray"       
    ## [677] "atherray"      "eadray"        "eadyray"       "ealray"       
    ## [681] "ealiseray"     "eallyray"      "easonray"      "eceiveray"    
    ## [685] "ecentray"      "eckonray"      "ecognizeray"   "ecommendray"  
    ## [689] "ecordray"      "edray"         "educeray"      "eferray"      
    ## [693] "egardray"      "egionray"      "elationray"    "ememberray"   
    ## [697] "eportray"      "epresentray"   "equireray"     "esearchray"   
    ## [701] "esourceray"    "espectray"     "esponsibleray" "estray"       
    ## [705] "esultray"      "eturnray"      "idray"         "ightray"      
    ## [709] "ingray"        "iseray"        "oadray"        "oleray"       
    ## [713] "ollray"        "oomray"        "oundray"       "uleray"       
    ## [717] "unray"         "afesay"        "alesay"        "amesay"       
    ## [721] "aturdaysay"    "avesay"        "aysay"         "chemesay"     
    ## [725] "choolsay"      "ciencesay"     "coresay"       "cotlandsay"   
    ## [729] "eatsay"        "econdsay"      "ecretarysay"   "ectionsay"    
    ## [733] "ecuresay"      "eesay"         "eemsay"        "elfsay"       
    ## [737] "ellsay"        "endsay"        "ensesay"       "eparatesay"   
    ## [741] "erioussay"     "ervesay"       "ervicesay"     "etsay"        
    ## [745] "ettlesay"      "evensay"       "exsay"         "hallsay"      
    ## [749] "haresay"       "hesay"         "heetsay"       "hoesay"       
    ## [753] "hootsay"       "hopsay"        "hortsay"       "houldsay"     
    ## [757] "howsay"        "hutsay"        "icksay"        "idesay"       
    ## [761] "ignsay"        "imilarsay"     "implesay"      "incesay"      
    ## [765] "ingsay"        "inglesay"      "irsay"         "istersay"     
    ## [769] "itsay"         "itesay"        "ituatesay"     "ixsay"        
    ## [773] "izesay"        "leepsay"       "lightsay"      "lowsay"       
    ## [777] "mallsay"       "mokesay"       "osay"          "ocialsay"     
    ## [781] "ocietysay"     "omesay"        "onsay"         "oonsay"       
    ## [785] "orrysay"       "ortsay"        "oundsay"       "outhsay"      
    ## [789] "pacesay"       "peaksay"       "pecialsay"     "pecificsay"   
    ## [793] "peedsay"       "pellsay"       "pendsay"       "quaresay"     
    ## [797] "taffsay"       "tagesay"       "tairssay"      "tandsay"      
    ## [801] "tandardsay"    "tartsay"       "tatesay"       "tationsay"    
    ## [805] "taysay"        "tepsay"        "ticksay"       "tillsay"      
    ## [809] "topsay"        "torysay"       "traightsay"    "trategysay"   
    ## [813] "treetsay"      "trikesay"      "trongsay"      "tructuresay"  
    ## [817] "tudentsay"     "tudysay"       "tuffsay"       "tupidsay"     
    ## [821] "ubjectsay"     "ucceedsay"     "uchsay"        "uddensay"     
    ## [825] "uggestsay"     "uitsay"        "ummersay"      "unsay"        
    ## [829] "undaysay"      "upplysay"      "upportsay"     "upposesay"    
    ## [833] "uresay"        "urprisesay"    "witchsay"      "ystemsay"     
    ## [837] "abletay"       "aketay"        "alktay"        "apetay"       
    ## [841] "axtay"         "eatay"         "eachtay"       "eamtay"       
    ## [845] "elephonetay"   "elevisiontay"  "elltay"        "entay"        
    ## [849] "endtay"        "ermtay"        "erribletay"    "esttay"       
    ## [853] "hantay"        "hanktay"       "hetay"         "hentay"       
    ## [857] "heretay"       "hereforetay"   "heytay"        "hingtay"      
    ## [861] "hinktay"       "hirteentay"    "hirtytay"      "histay"       
    ## [865] "houtay"        "houghtay"      "housandtay"    "hreetay"      
    ## [869] "hroughtay"     "hrowtay"       "hursdaytay"    "ietay"        
    ## [873] "imetay"        "otay"          "odaytay"       "ogethertay"   
    ## [877] "omorrowtay"    "onighttay"     "ootay"         "optay"        
    ## [881] "otaltay"       "ouchtay"       "owardtay"      "owntay"       
    ## [885] "radetay"       "raffictay"     "raintay"       "ransporttay"  
    ## [889] "raveltay"      "reattay"       "reetay"        "roubletay"    
    ## [893] "ruetay"        "rusttay"       "rytay"         "uesdaytay"    
    ## [897] "urntay"        "welvetay"      "wentytay"      "wotay"        
    ## [901] "ypetay"        "nderuay"       "nderstanduay"  "nionuay"      
    ## [905] "nituay"        "niteuay"       "niversityuay"  "nlessuay"     
    ## [909] "ntiluay"       "puay"          "ponuay"        "seuay"        
    ## [913] "sualuay"       "aluevay"       "ariousvay"     "eryvay"       
    ## [917] "ideovay"       "iewvay"        "illagevay"     "isitvay"      
    ## [921] "otevay"        "ageway"        "aitway"        "alkway"       
    ## [925] "allway"        "antway"        "arway"         "armway"       
    ## [929] "ashway"        "asteway"       "atchway"       "aterway"      
    ## [933] "ayway"         "eway"          "earway"        "ednesdayway"  
    ## [937] "eeway"         "eekway"        "eighway"       "elcomeway"    
    ## [941] "ellway"        "estway"        "hatway"        "henway"       
    ## [945] "hereway"       "hetherway"     "hichway"       "hileway"      
    ## [949] "hiteway"       "howay"         "holeway"       "hyway"        
    ## [953] "ideway"        "ifeway"        "illway"        "inway"        
    ## [957] "indway"        "indowway"      "ishway"        "ithway"       
    ## [961] "ithinway"      "ithoutway"     "omanway"       "onderway"     
    ## [965] "oodway"        "ordway"        "orkway"        "orldway"      
    ## [969] "orryway"       "orseway"       "orthway"       "ouldway"      
    ## [973] "riteway"       "rongway"       "earyay"        "esyay"        
    ## [977] "esterdayyay"   "etyay"         "ouyay"         "oungyay"

Find all countries that end in "y"

``` r
str_view_all_match(countries, "y$")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-25806611312ce1e4825f">{"x":{"html":"<ul>\n  <li>German<span class='match'>y<\/span><\/li>\n  <li>Hungar<span class='match'>y<\/span><\/li>\n  <li>Ital<span class='match'>y<\/span><\/li>\n  <li>Norwa<span class='match'>y<\/span><\/li>\n  <li>Paragua<span class='match'>y<\/span><\/li>\n  <li>Turke<span class='match'>y<\/span><\/li>\n  <li>Urugua<span class='match'>y<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Find all countries that have the same letter repeated twice (like "Greece", which has "ee").

``` r
str_view_all_match(countries, "(.)\\1")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-4e6356ace20ea31b1e25">{"x":{"html":"<ul>\n  <li>Camer<span class='match'>oo<\/span>n<\/li>\n  <li>Gr<span class='match'>ee<\/span>ce<\/li>\n  <li>Guinea-Bi<span class='match'>ss<\/span>au<\/li>\n  <li>Moro<span class='match'>cc<\/span>o<\/li>\n  <li>Phili<span class='match'>pp<\/span>ines<\/li>\n  <li>Sie<span class='match'>rr<\/span>a Leone<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Find all countries that end in two vowels.

``` r
str_view_all_match(countries, "[aeiou]{2}$")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-baf27a572bef1658736e">{"x":{"html":"<ul>\n  <li>Alban<span class='match'>ia<\/span><\/li>\n  <li>Alger<span class='match'>ia<\/span><\/li>\n  <li>Austral<span class='match'>ia<\/span><\/li>\n  <li>Austr<span class='match'>ia<\/span><\/li>\n  <li>Boliv<span class='match'>ia<\/span><\/li>\n  <li>Bulgar<span class='match'>ia<\/span><\/li>\n  <li>Cambod<span class='match'>ia<\/span><\/li>\n  <li>Colomb<span class='match'>ia<\/span><\/li>\n  <li>Croat<span class='match'>ia<\/span><\/li>\n  <li>Equatorial Guin<span class='match'>ea<\/span><\/li>\n  <li>Eritr<span class='match'>ea<\/span><\/li>\n  <li>Ethiop<span class='match'>ia<\/span><\/li>\n  <li>Gamb<span class='match'>ia<\/span><\/li>\n  <li>Guin<span class='match'>ea<\/span><\/li>\n  <li>Guinea-Biss<span class='match'>au<\/span><\/li>\n  <li>Ind<span class='match'>ia<\/span><\/li>\n  <li>Indones<span class='match'>ia<\/span><\/li>\n  <li>Liber<span class='match'>ia<\/span><\/li>\n  <li>Malays<span class='match'>ia<\/span><\/li>\n  <li>Mauritan<span class='match'>ia<\/span><\/li>\n  <li>Mongol<span class='match'>ia<\/span><\/li>\n  <li>Mozambiq<span class='match'>ue<\/span><\/li>\n  <li>Namib<span class='match'>ia<\/span><\/li>\n  <li>Nicarag<span class='match'>ua<\/span><\/li>\n  <li>Niger<span class='match'>ia<\/span><\/li>\n  <li>Roman<span class='match'>ia<\/span><\/li>\n  <li>Saudi Arab<span class='match'>ia<\/span><\/li>\n  <li>Serb<span class='match'>ia<\/span><\/li>\n  <li>Sloven<span class='match'>ia<\/span><\/li>\n  <li>Somal<span class='match'>ia<\/span><\/li>\n  <li>Syr<span class='match'>ia<\/span><\/li>\n  <li>Tanzan<span class='match'>ia<\/span><\/li>\n  <li>Tunis<span class='match'>ia<\/span><\/li>\n  <li>Zamb<span class='match'>ia<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Find all countries that start with two non-vowels. How is this different from finding all countries that end in *at least* two non-vowels? Hint: Syria.

``` r
countries %>% 
    str_to_lower() %>% 
    str_view_all_match("^[^aeiou]{2}")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-1736d0a521e23d7be0fa">{"x":{"html":"<ul>\n  <li><span class='match'>br<\/span>azil<\/li>\n  <li><span class='match'>ch<\/span>ad<\/li>\n  <li><span class='match'>ch<\/span>ile<\/li>\n  <li><span class='match'>ch<\/span>ina<\/li>\n  <li><span class='match'>cr<\/span>oatia<\/li>\n  <li><span class='match'>cz<\/span>ech republic<\/li>\n  <li><span class='match'>dj<\/span>ibouti<\/li>\n  <li><span class='match'>fr<\/span>ance<\/li>\n  <li><span class='match'>gh<\/span>ana<\/li>\n  <li><span class='match'>gr<\/span>eece<\/li>\n  <li><span class='match'>my<\/span>anmar<\/li>\n  <li><span class='match'>ph<\/span>ilippines<\/li>\n  <li><span class='match'>rw<\/span>anda<\/li>\n  <li><span class='match'>sl<\/span>ovak republic<\/li>\n  <li><span class='match'>sl<\/span>ovenia<\/li>\n  <li><span class='match'>sp<\/span>ain<\/li>\n  <li><span class='match'>sr<\/span>i lanka<\/li>\n  <li><span class='match'>sw<\/span>aziland<\/li>\n  <li><span class='match'>sw<\/span>eden<\/li>\n  <li><span class='match'>sw<\/span>itzerland<\/li>\n  <li><span class='match'>sy<\/span>ria<\/li>\n  <li><span class='match'>th<\/span>ailand<\/li>\n  <li><span class='match'>tr<\/span>inidad and tobago<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
Find all countries that have either "oo" or "cc" in them.

``` r
str_view_all_match(countries, "(oo|cc)")
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-90e7dca027ff305d82f9">{"x":{"html":"<ul>\n  <li>Camer<span class='match'>oo<\/span>n<\/li>\n  <li>Moro<span class='match'>cc<\/span>o<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
