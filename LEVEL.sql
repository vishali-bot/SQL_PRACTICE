--LEVEL 1
--Find all players who are alive, in severe debt (debt > 400,000,000 won), and are either elderly (age > 65) OR have a vice of Gambling with no family connections.

SELECT *
FROM player
WHERE status = 'alive'
  AND debt > 400000000
  AND (
        age > 65
        OR (
             vice = 'Gambling'
             AND has_close_family = 'false'
           )
      );

--LEVEL 2
--In a table, calculate how many rations would feed 90% of the remaining(alive) non-insider players (rounded down), and in another column, indicate if the current rations supply is sufficient. (True or False)

