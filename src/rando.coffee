underscore = require("underscore")

# word types
ADJECTIVE   = 0
NOUN        = 1
VERB        = 2
CONJUNCTION = 3

# pattern map
PATTERN_MAP = [
  [ADJECTIVE , NOUN        , NOUN]     ,
  [ADJECTIVE , ADJECTIVE   , NOUN]     ,
  [VERB      , CONJUNCTION , ADJECTIVE , NOUN]
  [ADJECTIVE , ADJECTIVE   , NOUN      , NOUN]
]

NUM_PATTERNS = 4

class Rando
  VOWELS = ["A", "E", "I", "O", "U"]

  randomSprintName: (bank, pattern) ->
    sprintName = ""
    usedWords = [""]

    generatedPattern = if pattern? then @_generatePattern(pattern) else []
    chosenPattern = if generatedPattern.length > 0 then generatedPattern else @_randomPattern()

    currentWordIndex = 0
    underscore.each chosenPattern, (type) =>
      randomWord = ""

      while usedWords.indexOf(randomWord) > -1
        switch type
          when ADJECTIVE   then randomWord = @_randomWord(bank.adjectives)
          when NOUN        then randomWord = @_randomWord(bank.nouns)
          when VERB        then randomWord = @_randomWord(bank.verbs)
          when CONJUNCTION
            randomWord = @_randomWord(bank.conjunctions)
            if currentWordIndex is 0
              randomWord = @_capitalizeFirstLetter(randomWord)

      lastWord = usedWords[usedWords.length - 1]
      usedWords.push(randomWord)

      if lastWord is "a" and @_startsWithAVowel(randomWord)
        sprintName += "n"

      sprintName += " " unless currentWordIndex is 0
      sprintName += randomWord

      currentWordIndex++

    sprintName

  _generatePattern: (pattern) ->
    uppercasePattern = pattern.toUpperCase()
    generatedPattern = []

    for letterIndex in [0..pattern.length-1]
      letter = uppercasePattern.charAt(letterIndex)

      type = switch letter
        when "A" then ADJECTIVE
        when "N" then NOUN
        when "V" then VERB
        when "C" then CONJUNCTION

      generatedPattern.push(type) if type?

    console.log("Got pattern: ", generatedPattern)
    generatedPattern

  _randomPattern: ->
    randomInt = @_randomInt(0, NUM_PATTERNS - 1)
    PATTERN_MAP[randomInt]

  _randomInt: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  _randomWord: (wordList) ->
    wordList[@_randomInt(0, wordList.length - 1)]

  _capitalizeFirstLetter: (word) ->
    word.charAt(0).toUpperCase() + word.slice(1)

  _startsWithAVowel: (word) ->
    firstCharacter = word.charAt(0)
    ["A", "E", "I", "O", "U"].indexOf(firstCharacter) > -1

createGenerator = ->
  new Rando()

module.exports = createGenerator
