## Code Structure Decisions                                                          
                                                                                       
  Distinguish between *tidying* and *speculative abstraction*:                     
                                                                                       
  *Tidy* when you're struggling to make a behaviour change you need to make NOW:     
  - Code is hard to understand → explaining variables, reading order                   
  - Change touches many places → cohesion order, extract helper                        
  - Structure obscures intent → guard clauses, normalise symmetries                    
                                                                                       
  *Don't abstract* when you're imagining future needs:                               
  - "We might need..." → You don't need it yet                                         
  - Interface with one implementation → Delete the interface                           
  - "Reusable" component with one use → Inline it                                      
  - DRYing coincidentally similar code → Let it repeat                                 
                                                                                       
  *Decision test*: Is there a concrete behaviour change driving this?                
  - Yes + structure makes it harder → tidy first                                       
  - Yes + structure is fine → just make the change                                     
  - No → don't touch it                                                                
                                                                                       
  Simple code flexes; "flexible" code is rigid. Premature abstraction creates the      
  coupling it claims to prevent.                                                       
                                                                                       
  The key insight to embed: tidying serves a behaviour change you're making now. The   
  moment you're "improving" code without a driving change, you've crossed from tidying 
  into speculation