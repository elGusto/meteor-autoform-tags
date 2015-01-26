AutoForm.addInputType 'tags',
	template: 'autoformTags'
	valueOut: ->
		@val()
	valueConverters:
		stringArray: (value) ->
			value.split ','
	contextAdjust: (context) ->
		_.extend context.atts, {itemscontextValue: context.value}
		context

Template.autoformTags.rendered = ->
	self = @$ '.js-input'

	self.closest('form').on 'reset', ->
		self.tagsinput 'removeAll'

	self.tagsinput @data.atts

	if @data.atts.itemscontextValue
		if @data.atts.collection
			collection = if (@data.atts.collection is 'users') then Meteor.users else window[@data.atts.collection]
			relObjs = collection.find({_id: {$in: @data.atts.itemscontextValue}}).fetch()
			_.each relObjs, (doc) ->
				self.tagsinput 'add', doc
		else
			_.each @itemscontextValue, (val) ->
				self.tagsinput 'add', val

Template.autoformTags.helpers
	schemaKey: ->
		@atts['data-schema-key']

