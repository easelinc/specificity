# Calculate the specificity of a css selector.
# See http://www.w3.org/TR/selectors/#specificity
# code from: https://gist.github.com/2956735
#
# selector - a string css selector
#
# Returns an integer
$.specificity = (selector) ->
  specificity = [0,0,0,0,0]
  tmp = 0
  selectors = selector.split(/\s*,\s*/)

  for sel in selectors
    # id selectors
    matches = sel.match(/#/g);
    specificity[1] += matches.length if matches
    # class selectors
    matches = sel.match(/\./g);
    specificity[2] += matches.length if matches
    # attribute selectors
    matches = sel.match(/\[.+\]/g);
    specificity[2] += matches.length if matches
    # pseudo-element selectors
    matches = sel.match(/:(?:first-letter|first-line|before|after|:selection)/g)
    if matches
      tmp = matches.length
      specificity[3] += tmp

    # pseudo-(element and class) selectors
    matches = sel.match(/:/g)
    specificity[2] += (matches.length - tmp) if matches # filter out the count of lower-precedence matches of pseudo-elements
    tmp = 0;
    # child, adjacent-sibling, and general-sibling combinators (Note: extension to CSS3 algorithm)
    matches = sel.match(/[+>~]/g)
    specificity[4] += matches.length if matches
    # element type selectors (note: must remove everything else to find this count)
    sel = sel
      .replace(/\(.*?\)/g,"")
      .replace(/\[.*?\]/g,"")
      .replace(/[.#:][^ +>~]*/ig,"")
    matches = sel.match(/[^ +>~]+/g)
    specificity[3] += matches.length if matches

  # convert the array of specificities to an integer for comparison purposes
  # earlier in the array == higher order.
  m = 10000
  result = 0
  for p in specificity
    result += p*m
    m /= 10

  result