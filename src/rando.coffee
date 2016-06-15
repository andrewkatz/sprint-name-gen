# word types
ADJECTIVE   = "adjective"
NOUN        = "noun"
VERB        = "verb"
CONJUNCTION = "conjunction"

# pattern map
PATTERN_MAP = [
  [ADJECTIVE   , NOUN        , NOUN],
  [ADJECTIVE   , ADJECTIVE   , NOUN],
  [VERB        , CONJUNCTION , ADJECTIVE , NOUN],
  [ADJECTIVE   , ADJECTIVE   , NOUN      , NOUN],
  [CONJUNCTION , ADJECTIVE   , NOUN]
]

class Rando
  VOWELS = ["A", "E", "I", "O", "U"]

  randomSprintName: (bank, pattern) ->
    sprintName = []
    usedWords =
      "adjective":   []
      "verb":        []
      "noun":        []
      "conjunction": []

    generatedPattern = if pattern? then @_generatePattern(pattern) else []
    chosenPattern = if generatedPattern.length > 0 then generatedPattern else @_randomPattern()

    for type, currentWordIndex in chosenPattern
      randomWord = ""
      currentIndex = -1

      wordList = switch type
        when ADJECTIVE   then bank.adjectives
        when NOUN        then bank.nouns
        when VERB        then bank.verbs
        when CONJUNCTION then bank.conjunctions

      while currentIndex < 0 or usedWords[type].indexOf(currentIndex) > -1
        currentIndex = @_randomIndex(wordList)

      usedWords[type].push(currentIndex)
      randomWord = @_randomWord(wordList, currentIndex)

      if currentWordIndex is 0
        randomWord = @_capitalizeFirstLetter(randomWord)

      lastWord = sprintName[sprintName.length - 1]

      if lastWord? and lastWord.toLowerCase() is "a" and @_startsWithAVowel(randomWord)
        sprintName.push("n")

      sprintName.push(" ") unless currentWordIndex is 0
      sprintName.push(randomWord)

    sprintName.join("")

  _generatePattern: (pattern) ->
    uppercasePattern = pattern.toUpperCase()
    generatedPattern = []

    for letter in uppercasePattern
      type = switch letter
        when "A" then ADJECTIVE
        when "N" then NOUN
        when "V" then VERB
        when "C" then CONJUNCTION

      generatedPattern.push(type) if type?

    console.log("Got pattern: ", generatedPattern)
    generatedPattern

  _randomPattern: ->
    randomInt = @_randomInt(0, PATTERN_MAP.length - 1)
    PATTERN_MAP[randomInt]

  _randomInt: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  _randomIndex: (wordList) ->
    @_randomInt(0, wordList.length - 1)

  _randomWord: (wordList, index) ->
    choiceList = wordList[index]
    choiceList[@_randomInt(0, choiceList.length - 1)]

  _capitalizeFirstLetter: (word) ->
    word.charAt(0).toUpperCase() + word.slice(1)

  _startsWithAVowel: (word) ->
    firstCharacter = word.charAt(0)
    ["A", "E", "I", "O", "U"].indexOf(firstCharacter) > -1

createGenerator = ->
  new Rando()

module.exports = createGenerator
