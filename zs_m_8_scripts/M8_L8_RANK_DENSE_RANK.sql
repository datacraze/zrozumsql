DROP TABLE IF EXISTS game_ranking;

CREATE TABLE game_ranking (
	id SERIAL,
	player_nickname VARCHAR(100),
	score INTEGER
);

INSERT INTO game_ranking (player_nickname, score)
	  VALUES ('djones', 1100),
	 		 ('kbury',990),
	 		 ('alapino', 720),
	 		 ('belginia', 720),
	 		 ('jsmith', 420);

-- 
   SELECT gr.player_nickname,
   		  gr.score
     FROM game_ranking gr
;       
 
   SELECT gr.player_nickname,
   		  gr.score,
   		  rank() OVER (PARTITION BY player_nickname ORDER BY gr.score desc)
     FROM game_ranking gr
;  

   SELECT gr.player_nickname,
   		  gr.score,
   		  rank() OVER (ORDER BY gr.score desc)
     FROM game_ranking gr
; 

   SELECT gr.player_nickname,
   		  gr.score,
   		  dense_rank() OVER (ORDER BY gr.score desc)
     FROM game_ranking gr
; 

-- JAK WYBIERZESZ OSOBE NA 4 MIEJSCU

   SELECT * 
     FROM game_ranking gr
 ORDER BY gr.score DESC
    LIMIT 1 OFFSET 3
;

-- UPS 

   SELECT DISTINCT ON (gr.score) 
          gr.player_nickname,
   		  gr.score
     FROM game_ranking gr
    ORDER BY gr.score DESC 
    LIMIT 1 OFFSET 3 
     
;

   SELECT gr.player_nickname,
   		  gr.score,
   		  rank() OVER (ORDER BY gr.score desc)
     FROM game_ranking gr
    ORDER BY 3 DESC 
    LIMIT 1
; -- a co jak beda mniejsze wyniki?

   SELECT * 
     FROM (SELECT gr.player_nickname,
   		          gr.score,
        		  dense_rank() OVER (ORDER BY gr.score desc) drank
             FROM game_ranking gr) sq 
    WHERE sq.drank = 4
; 

 
            	