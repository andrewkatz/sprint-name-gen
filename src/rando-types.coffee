# word types
ADJECTIVE = 0
VERB      = 1
NOUN      = 2

# patterns
ADJECTIVE_NOUN_NOUN = 0
NOUN_NOUN_NOUN      = 1

# pattern map
patternMap =
  ADJECTIVE_NOUN_NOUN : [ADJECTIVE, NOUN, NOUN]
  NOUN_NOUN_NOUN      : [NOUN, NOUN, NOUN]
