describe '$.specificity', ->

  it 'ids > classes', ->
    expect($.specificity('#someid')).toBeGreaterThan($.specificity('.someclass'))

  it 'more classes == more specificity', ->
    expect($.specificity('.clazz div.ok')).toBeGreaterThan($.specificity('.clazz div'))

  describe 'applying to an element', ->

    beforeEach ->
      @el = $ '<button/>',
        'class': 'one two'
        id: 'btn'

    afterEach ->
      @el.remove()

    it 'only calculates for the selector applying to the element', ->
      expected = $.specificity('button')
      actual = $.specificity('label.omg, button, #cats', element: @el)
      expect(actual).toEqual(expected)

    it 'chooses highest specifity', ->
      expected = $.specificity('button#btn')
      actual = $.specificity('.btn, button, button#btn', element: @el)
      expect(actual).toEqual(expected)

    it 'returns 0 when no match', ->
      expected = 0
      actual = $.specificity('#nope', element: @el)
      expect(actual).toEqual(expected)

