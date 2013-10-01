import Test.HUnit
import Highlight

main = runTestTT $ TestList [
    insertTests, 
    applyTests
    ]
    
insertTests = TestList [
    "insertion at head" ~: [8, 9, 1, 2, 3] ~=? insert [1, 2, 3] [(0, [8, 9])], 
    "insertion at head" ~: [1, 2, 3, 8, 9] ~=? insert [1, 2, 3] [(3, [8, 9])],
    "insertion at middle" ~: [1, 2, 8, 9, 3] ~=? insert [1, 2, 3] [(2, [8, 9])]
    ]

applyTests = TestList [
    "applying a single rule" ~: 
        [(4, "<"), (7, ">")] ~=? 
        apply [Rule "red" "<" ">"] "the red color",
        
    "applying a rule with a regex" ~: 
        [(11, "<"), (14, ">")] ~=? 
        apply [Rule "[0-9]+" "<" ">"] "the number 123",
    
    "applying multiple rules" ~: 
        [(4, "<"), (7, ">"), (12, "["), (17, "]")] ~=? 
        apply [Rule "red" "<" ">", Rule "white" "[" "]"] "the red and white color",
        
    "applying two collapsing rules" ~: 
        [(4, "<"), (7, ">"), (0, "["), (7, "]")] ~=? 
        apply [Rule "red" "<" ">", Rule "the red" "[" "]"] "the red and white color"
    ]
