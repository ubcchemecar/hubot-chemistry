chemcalc = require('chemcalc')

module.exports = (robot) ->
  robot.hear /make me (\d*)mL (\d*)M (.*)/i, (res) ->
    # Grab the numbers from the message
    volume = res.match[1]
    molarity = res.match[2]
    chemical = res.match[3]

    # Using an external library to get the molecular weight
    result = chemcalc.analyseMF(chemical)
    mw = result.mw

    # Calculate the mass
    moles = volume*molarity/1000
    mass = moles*mw

    # Send the results back
    res.send "#{chemical}'s molecular weight is #{result.mw}"
    res.send "To make #{volume}mL of #{molarity}M #{chemical}, you need to add #{mass.toFixed(4)}g"
    res.send "Remember to divide by the assay, you're welcome."
