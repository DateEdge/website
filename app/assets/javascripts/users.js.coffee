$ ->
  $("#user_label_id").change ->
    # TODO this is fragile and we should make it more betterer
    if parseInt($(this).val()) == 4 # hardcoded DB ID
      $("#drug-use").removeClass('hidden')
    else
      $("#drug-use").addClass('hidden')
