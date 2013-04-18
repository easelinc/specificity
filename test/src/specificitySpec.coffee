describe '$.specificity', ->

  it 'ids > classes', ->
    expect($.specificity('#someid')).toBeGreaterThan($.specificity('.someclass'))

  it 'more classes == more specificity', ->
    expect($.specificity('.clazz div.ok')).toBeGreaterThan($.specificity('.clazz div'))
