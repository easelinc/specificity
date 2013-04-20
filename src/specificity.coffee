# Calculate the specificity of a css selector.
# See http://www.w3.org/TR/selectors/#specificity
# code from: https://gist.github.com/2956735
#
# selector - a string css selector
# options:
#   element - an element that the selector should apply to
#
# Returns an integer
$.specificity = (selector, options={}) ->
  if options.element
    # When an element is passed in, we figure out which selectors (i.e.
    # selector = 'button, button.btn') match the element, then calc the
    # specifity on those, and return the highest specifity we find.
    element = options.element
    element = element[0] if element instanceof jQuery

    selectors = selector.split(',')
    specifities = (_specificity(sel) for sel in selectors when _matchesSelector(element, sel))

    highestSpecificity = 0
    for spec in specifities
      highestSpecificity = spec if spec > highestSpecificity
    return highestSpecificity

  else
    return _specificity(selector)

# Actual specifity calculation
_specificity = (selector) ->
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

# element - an HTMLElement (not jquery obj)
_matchesSelector = (element, selector) ->
  fn = element.matchesSelector or element.mozMatchesSelector or element.webkitMatchesSelector
  try
    # in try/catch as there might be an 'invalid' selector.
    return fn.call(element, selector)
  catch e
    ;

  null