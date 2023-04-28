--���37�I 49�I 50! 51! 52! 58! 64!
--�킩��Ȃ����:23 22 �V33
--�����Ɗ֌W����SQL�����ׂĎ��s�o���Ȃ�18,19�A20,21�Ƃ�


--���1�F�e�O���[�v�̒���FIFA�����N���ł��������ƒႢ���̃����L���O�ԍ���\�����Ă��������B
SELECT
    group_name AS �O���[�v
    , MIN(ranking) AS �����L���O�ŏ��
    , MAX(ranking) AS �����L���O�ŉ��� 
FROM
    countries 
GROUP BY
    group_name
    
    

--���2�F�S�S�[���L�[�p�[�̕��ϐg���A���ϑ̏d��\�����Ă�������
select avg(height) as ���ϐg��, avg(weight) as ���ϑ̏d from players



--���3�F�e���̕��ϐg�������������珇�ɕ\�����Ă��������B�������AFROM���countries�e�[�u���Ƃ��Ă��������B
select
    countries.name
    , avg(players.height) 
from
    countries join players 
        on countries.id = players.country_id 
group by
    countries.id
    , countries.name 
order by
    avg(players.height) desc



--���4�F�e���̕��ϐg�������������珇�ɕ\�����Ă��������B�������AFROM���players�e�[�u���Ƃ��āA�e�[�u���������g�킸���⍇����p���Ă��������B
select
    ( 
        select
            c.name 
        from
            countries c 
        where
            c.id = p.country_id
    ) as ��
    , avg(p.height) as ���ϐg�� 
from
    players p 
group by
    p.country_id 
order by
    avg(p.height) desc;




--���5�F�L�b�N�I�t�����Ƒΐ퍑�̍������L�b�N�I�t�����̑������̂��珇�ɕ\�����Ă�������
SELECT
    kickoff AS �L�b�N�I�t����
    , c1.name AS ����1
    , c2.name AS ����2 
FROM
    pairings p 
    LEFT JOIN countries c1 
        ON p.my_country_id = c1.id 
    LEFT JOIN countries c2 
        ON p.enemy_country_id = c2.id 
ORDER BY
    kickoff
    
    

--���6�F���ׂĂ̑I���ΏۂƂ��đI�育�Ƃ̓��_�����L���O��\�����Ă��������B�iSELECT��ŕ��⍇�����g�����Ɓj
SELECT p.name AS ���O, p.position AS �|�W�V����, p.club AS �����N���u, 
    (SELECT COUNT(id) FROM goals g WHERE g.player_id = p.id) AS �S�[����
FROM players p
ORDER BY �S�[���� DESC



--���7�F���ׂĂ̑I���ΏۂƂ��đI�育�Ƃ̓��_�����L���O��\�����Ă��������B�i�e�[�u���������g�����Ɓj
SELECT
    p.name AS ���O
    , p.position AS �|�W�V����
    , p.club AS �����N���u
    , COUNT(g.id) AS �S�[���� 
FROM
    players p 
    LEFT JOIN goals g 
        ON g.player_id = p.id 
GROUP BY
    p.id
    , p.name
    , p.position
    , p.club 
ORDER BY
    �S�[���� DESC



--���8�F�e�|�W�V�������Ƃ̑����_��\�����Ă��������B
select
    p.position
    , count(g.id) 
from
    players p 
    left join goals g 
        on p.id = g.player_id 
group by
    p.position



--���9�F���[���h�J�b�v�J�Ó����i2014-06-13�j�̔N����v���C���[���ɕ\������B
SELECT
    birth
    , TIMESTAMPDIFF(YEAR, birth, '2014-06-13') AS age
    , name
    , position 
FROM
    players 
ORDER BY
    age DESC;


--���10�F�I�E���S�[���̉񐔂�\������
SELECT
    COUNT(g.goal_time) 
FROM
    goals g 
WHERE
    g.player_id IS NULL;



--���11�F�e�O���[�v���Ƃ̑����_����\�����ĉ������B
SELECT
    c.group_name
    , count(g.id) 
FROM
    goals g 
    LEFT JOIN pairings p 
        ON p.id = g.pairing_id 
    LEFT JOIN countries c 
        ON p.my_country_id = c.id 
WHERE
    p.kickoff BETWEEN '2014-06-13 0:00:00' AND '2014-06-27 23:59:59' 
GROUP BY
    c.group_name



--���12�F���{VS�R�����r�A��ipairings.id = 103�j�ł̃R�����r�A�̓��_�̃S�[�����Ԃ�\�����Ă�������
SELECT
    goal_time 
FROM
    goals 
WHERE
    pairing_id = 103



--���13�F���{VS�R�����r�A��̏��s��\�����ĉ������B
SELECT
    c.name
    , COUNT(g.goal_time) 
FROM
    goals g 
    LEFT JOIN pairings p 
        ON p.id = g.pairing_id 
    LEFT JOIN countries c 
        ON p.my_country_id = c.id 
WHERE
    p.id = 103 
    OR p.id = 39 
GROUP BY
    c.name


select * from countries as ��;
select * from pairings as �����;
select * from goals as �_�����;



--���14�F�O���[�vC�̊e�ΐ했�ɃS�[������\�����Ă�������
SELECT p1.kickoff, c1.name AS my_country, c2.name AS enemy_country,
    c1.ranking AS my_ranking, c2.ranking AS enemy_ranking,
    COUNT(g1.id) AS my_goals
FROM pairings p1
LEFT JOIN countries c1 ON c1.id = p1.my_country_id
LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
LEFT JOIN goals g1 ON p1.id = g1.pairing_id
WHERE c1.group_name = 'C' AND c2.group_name = 'C'
GROUP BY p1.kickoff, c1.name, c2.name, c1.ranking, c2.ranking
ORDER BY p1.kickoff, c1.ranking



--���15�F�O���[�vC�̊e�ΐ했�ɃS�[������\�����Ă��������B
--���P�S�Ɠ���



--���16�F�O���[�vC�̊e�ΐ했�ɃS�[������\�����Ă��������B
SELECT p1.kickoff, c1.name AS my_country, c2.name AS enemy_country, 
    c1.ranking AS my_ranking, c2.ranking AS enemy_ranking,
   
    (SELECT COUNT(g1.id) FROM goals g1 WHERE p1.id = g1.pairing_id) AS my_goals,
    (
        SELECT COUNT(g2.id) 
        FROM goals g2 
        LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
        WHERE p2.my_country_id = p1.enemy_country_id AND p2.enemy_country_id = p1.my_country_id
    ) AS enemy_goals
FROM pairings p1
LEFT JOIN countries c1 ON c1.id = p1.my_country_id
LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
WHERE c1.group_name = 'C' AND c2.group_name = 'C'
ORDER BY p1.kickoff, c1.ranking



--���17�F���16�̌��ʂɓ����_����ǉ����Ă��������B
SELECT p1.kickoff, c1.name AS my_country, c2.name AS enemy_country, 
    c1.ranking AS my_ranking, c2.ranking AS enemy_ranking,
    (SELECT COUNT(g1.id) FROM goals g1 WHERE p1.id = g1.pairing_id) AS my_goals,
    (
        SELECT COUNT(g2.id) 
        FROM goals g2 
        LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
        WHERE p2.my_country_id = p1.enemy_country_id AND p2.enemy_country_id = p1.my_country_id
    ) AS enemy_goals,
    -- �ǉ���������
    (SELECT COUNT(g1.id) FROM goals g1 WHERE p1.id = g1.pairing_id) - ( 
        SELECT COUNT(g2.id) 
        FROM goals g2 
        LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
        WHERE p2.my_country_id = p1.enemy_country_id AND p2.enemy_country_id = p1.my_country_id
    ) AS goal_diff
    -- �ǉ������܂�
FROM pairings p1
LEFT JOIN countries c1 ON c1.id = p1.my_country_id
LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
WHERE c1.group_name = 'C' AND c2.group_name = 'C'
ORDER BY p1.kickoff, c1.ranking



--���18�F�u���W���imy_country_id = 1�j�΃N���A�`�A�ienemy_country_id = 4�j��̃L�b�N�I�t���ԁi���n���ԁj��\�����Ă��������B
SELECT
    p.kickoff
    , p.kickoff - cast('12 hours' as INTERVAL) AS kickoff_jp 
FROM
    pairings p 
WHERE
    p.my_country_id = 1 
    AND p.enemy_country_id = 4;


--���19�F�N��Ƃ̑I�萔��\�����Ă��������B�i�N��̓��[���h�J�b�v�J�Ó����ł���2014-06-13���g���ĎZ�o���Ă��������B�j
select
    date_part('year', AGE('2014-06-13', birth)) as age
    , COUNT(id) AS player_count 
FROM
    players 
GROUP BY
    age 
order by
    age



--���20�F�N��Ƃ̑I�萔��\�����Ă��������B�������A10�Ζ��ɍ��Z���ĕ\�����Ă��������B
select
    count(date_part('year', AGE('2014-06-13', birth)) between 10 and 20) as age,
    COUNT(id) AS player_count 
FROM
    players 
    where 
    date_part('year', AGE('2014-06-13', birth)) between 10 and 20 
order by
    age
    
    

    select
        date_part('year', AGE('2014-06-13', birth)) as age
        , COUNT(id)AS player_count 
    FROM
        players where 
        date_part('year', AGE('2014-06-13', birth)) between 10 and 19 
    GROUP BY
        age 
    order by
        age



---���21�F�N��Ƃ̑I�萔��\�����Ă��������B�������A5�Ζ��ɍ��Z���ĕ\�����Ă��������B



--���22�F�ȉ��̏�����SQL���쐬���A���o���ꂽ���ʂ����Ƃɂǂ̂悤�ȌX�������邩�l���Ă݂Ă��������B
SELECT FLOOR(TIMESTAMPDIFF(YEAR, birth, '2014-06-13') / 5) * 5   AS age, position, COUNT(id) AS player_count, AVG(height), AVG(weight)
FROM players 
GROUP BY age, position
ORDER BY age, position



--���23�F�g���̍����I��x�X�g5�𒊏o���A�ȉ��̍��ڂ�\�����Ă��������B
SELECT name, height, weight
FROM players
ORDER BY height DESC
LIMIT 5



--���24�F�g���̍����I��6�ʁ`20�ʂ𒊏o���A�ȉ��̍��ڂ�\�����Ă��������B
SELECT name, height, weight
FROM players
ORDER BY height DESC
LIMIT (5) offset (15)




--���25�F�S�I��̈ȉ��̃f�[�^�𒊏o���Ă��������B
         --�E�w�ԍ��iuniform_num�j
         --�E���O�iname�j
         --�E�����N���u�iclub�j
select uniform_num,name,club from players;



--���26�F�O���[�vC�ɏ������鍑�����ׂĒ��o���Ă��������B
select * from countries where group_name = 'C';



--���27�F�O���[�vC�ȊO�ɏ������鍑�����ׂĒ��o���Ă�������
select * from countries where group_name <> 'C';



--���28�F2016�N1��13�����݂�40�Έȏ�̑I��𒊏o���Ă��������B�i�a�����̐l���܂߂Ă��������B�j
select * from players where birth <= '1976-1-13';



--���29�F�g����170cm�����̑I��𒊏o���Ă��������B
select * from players where height < 170;



--���30�FFIFA�����N�����{�i46�ʁj�̑O��10�ʂɊY�����鍑�i36�ʁ`56�ʁj�𒊏o���Ă��������B�������ABETWEEN���p���Ă��������B
select * from countries where ranking between 36 and 56;



--���31�F�I��̃|�W�V������GK�ADF�AMF�ɊY������I������ׂĒ��o���Ă��������B�������AIN���p���Ă��������B
select * from players where position in ('GK','DF','MF');



--���32�F�I�E���S�[���ƂȂ����S�[���𒊏o���Ă��������Bgoals�e�[�u����player_id�J������NULL���i�[����Ă���f�[�^���I�E���S�[����\���Ă��܂��B
select * from goals where player_id is NULL;



--���33�F�I�E���S�[���ȊO�̃S�[���𒊏o���Ă��������Bgoals�e�[�u����player_id�J������NULL���i�[����Ă���f�[�^���I�E���S�[����\���Ă��܂��B
select * from goals where player_id is not null;



--���34�F���O�̖������u�j���v�ŏI���v���C���[�𒊏o���Ă��������B
select * from players where name like  '%�j��';



--���35�F���O�̒��Ɂu�j���v���܂܂��v���C���[�𒊏o���Ă��������B
select * from players where name like '%�j��%';



--���36�F�O���[�vA�ȊO�ɏ������鍑�����ׂĒ��o���Ă��������B�������A�u!=�v��u<>�v���g�킸�ɁA�uNOT�v���g�p���Ă��������B
select * from countries where not group_name = 'A';



--���37�F�S�I��̒���BMI�l��20��̑I��𒊏o���Ă��������BBMI�͈ȉ��̎��ŋ��߂邱�Ƃ��ł��܂��B
--sql�̒��ŁA�Q�̓��̏�������pow(2,2) 
select * from players where weight / POW (height / 100,2) > =20 and weight / POW (height / 100,2) < 21



--���38�F�S�I��̒����珬���ȑI��i�g����165cm�������A�̏d��60kg�����j�𒊏o���Ă��������B
select * from players where height < 165 or height < 60



--���39�FFW��MF�̒���170�����̑I��𒊏o���Ă��������B�������AOR��AND���g�p���Ă��������B
select * from players where ( position = 'MF' or position = 'FW') and height < 170



--���40�F�|�W�V�����̈ꗗ���d���Ȃ��ŕ\�����Ă��������B�O���[�v���͎g�p���Ȃ��ł��������B
select distinct position from players



--���41�F�S�I��̐g���Ƒ̏d�𑫂����l��\�����Ă��������B���킹�đI��̖��O�A�I��̏����N���u���\�����Ă��������B
select name ,club ,height + weight from players



--���42�F�I�薼�ƃ|�W�V�������ȉ��̌`���ŏo�͂��Ă��������B�V���O���N�H�[�g�ɒ��ӂ��Ă��������B
select
    concat(name, '�I��̃|�W�V������', position, '�ł�') 
from
    players;



--���43�F�S�I��̐g���Ƒ̏d�𑫂����l���J�������u�̗͎w���v�Ƃ��ĕ\�����Ă��������B���킹�đI��̖��O�A�I��̏����N���u���\�����Ă��������B
select 
   name,club,height + weight as �̗͎w��
from 
    players;
    
    

--���44�FFIFA�����N�̍��������珇�ɂ��ׂĂ̍�����\�����Ă��������B
select 
    ranking
from
    countries order by ranking;
    
    
    
--���45�F�S�Ă̑I���N��̒Ⴂ���ɕ\�����Ă��������B�Ȃ��A�N����v�Z����K�v�͂���܂���B
select
    * 
from
    players 
order by
    birth desc;
    
    
    
--���46�F�S�Ă̑I���g���̑傫�����ɕ\�����Ă��������B�����g���̑I��͑̏d�̏d�����ɕ\�����Ă��������B
select
    * 
from
    players 
order by
    height desc
    , weight desc;



--���47�F�S�Ă̑I��̃|�W�V������1�����ځiGK�ł����G�AFW�ł����F�j���o�͂��Ă��������B
select
    id
    , country_id
    , uniform_num
    , substring(position, 1, 1)
    , name 
from
    players;



--���48�F�o�ꍑ�̍������������̂��珇�ɏo�͂��Ă��������B
select
    name 
from
    countries 
order by
    length(name) desc;



---���49�F�S�I��̒a�������u2017�N04��30���v�̃t�H�[�}�b�g�ŏo�͂��Ă��������B
select
    name
    ,date_format(birth,'%y�N%m��%d��') as birthday
from 
    players;
    
    
    
--���50�F�S�ẴS�[�������o�͂��Ă��������B�������A�I�E���S�[���iplayer_id��NULL�̃f�[�^�j��IFNULL�֐����g�p����player_id���u9999�v�ƕ\�����Ă��������B
select 
    IFNULL(player_id,9999) as player_id, goal_time
from 
    goals
    


--���51�F�S�ẴS�[�������o�͂��Ă��������B�������A�I�E���S�[���iplayer_id��NULL�̃f�[�^�j��CASE�֐����g�p����player_id���u9999�v�ƕ\�����Ă��������B
SELECT
    CASE 
        WHEN player_id IS NULL 
            THEN 9999 
        ELSE player_id 
        END AS player_id
    , goal_time 
FROM
    goals



--���52�F�S�Ă̑I��̕��ϐg���A���ϑ̏d��\�����Ă��������B
select
    avg(height) as ���ϐg��
    , avg(weight) as ���ϑ̏d
from
    players;



--���53�F���{�̑I��iplayer_id��714����736�j���グ���S�[������\�����Ă��������B
select
    count(id) as ���{�̃S�[���� 
from
    goals 
where
    player_id between 714 and 736;



--���54�F�I�E���S�[���iplayer_id��NULL�j�ȊO�̑��S�[������\�����Ă��������B�������AWHERE��͎g�p���Ȃ��ł��������B
SELECT
    COUNT(player_id) AS �I�E���S�[���ȊO�̃S�[���� 
FROM
    goals;



--���55�F�S�Ă̑I��̒��ōł������g���ƁA�ł��d���̏d��\�����Ă��������B
select
    max(height) as �ł������g��
    , max(weight) as �ł��d���̏d 
from
    players;



--���56�FA�O���[�v��FIFA�����N�ŏ�ʂ�\�����Ă��������B
SELECT
    MIN(ranking) AS A�O���[�v��FIFA�����N�ŏ�� 
FROM
    countries 
WHERE
    group_name = 'A';



--���57�FC�O���[�v��FIFA�����N�̍��v�l��\�����Ă��������B
select
    sum(ranking) as C�O���[�v��FIFA�����N�̍��v�l 
from
    countries 
where
    group_name = 'C';



--���58�F�S�Ă̑I��̏������Ɩ��O�A�w�ԍ���\�����Ă��������B
SELECT c.name, p.name, p.uniform_num
FROM players p
JOIN countries c ON c.id = p.country_id



--���59�F�S�Ă̎����̍����ƑI�薼�A���_���Ԃ�\�����Ă��������B�I�E���S�[���iplayer_id��NULL�j�͕\�����Ȃ��ł��������B

SELECT c.name, p.name, g.goal_time
FROM goals g
JOIN players p ON g.player_id = p.id
JOIN countries c ON p.country_id = c.id



--���60�F�S�Ă̎����̃S�[�����ԂƑI�薼��\�����Ă��������B�����O���������g�p���ăI�E���S�[���iplayer_id��NULL�j���\�����Ă�������
SELECT g.goal_time, p.name
FROM goals g
LEFT JOIN players p ON g.player_id = p.id



--���61�F�S�Ă̎����̃S�[�����ԂƑI�薼��\�����Ă��������B�E���O���������g�p���ăI�E���S�[���iplayer_id��NULL�j���\�����Ă��������B
select g.goal_time, p.name
from players p
right join goals g ON g.player_id = p.id



--���62�F�S�Ă̎����̃S�[�����ԂƑI�薼�A������\�����Ă��������B�܂��A�I�E���S�[���iplayer_id��NULL�j���\�����Ă��������B
SELECT c.name , g.goal_time,  p.name
FROM goals g
LEFT JOIN players p ON g.player_id = p.id
LEFT JOIN countries c ON p.country_id = c.id

SELECT c.name AS country_name, g.goal_time, p.position, p.name AS player_name
FROM goals g
LEFT JOIN players p ON g.player_id = p.id
LEFT JOIN countries c ON p.country_id = c.id



--���63�F�S�Ă̎����̃L�b�N�I�t���ԂƑΐ퍑�̍�����\�����Ă��������B
SELECT
    p.kickoff
    , mc.name AS my_country
    , ec.name AS enemy_country 
FROM
    pairings p JOIN countries mc 
        ON mc.id = my_country_id JOIN countries ec 
        on ec.id = enemy_country_id




--���64�F�S�ẴS�[�����ԂƓ��_���グ���v���C���[����\�����Ă��������B�I�E���S�[���͕\�����Ȃ��ł��������B�������A�����͎g�킸�ɕ��⍇����p���Ă��������B
SELECT
    g.id
    , g.goal_time
    , ( 
        SELECT
            p.name 
        FROM
            players p 
        WHERE
            p.id = g.player_id
    ) AS player_name 
FROM
    goals g 
WHERE
    g.player_id IS NOT NULL



--���65�F�S�ẴS�[�����ԂƓ��_���グ���v���C���[����\�����Ă��������B�I�E���S�[���͕\�����Ȃ��ł��������B�������A���⍇���͎g�킸�ɁA������p���Ă��������B
SELECT
    
    g.goal_time
    , p.name 
FROM
    goals g JOIN players p 
        ON p.id = g.player_id



--���66�F�e�|�W�V�������ƁiGK�AFW�Ȃǁj�ɍł��g���ƁA���̑I�薼�A�����N���u��\�����Ă��������B�������AFROM��ɕ��⍇�����g�p���Ă�������
SELECT
    p1.position
    , p1.�ő�g��
    , p2.name
    , p2.club 
FROM
    ( 
        SELECT
            position
            , MAX(height) AS �ő�g�� 
        FROM
            players 
        GROUP BY
            position
    ) p1 
    LEFT JOIN players p2 
        ON p1.�ő�g�� = p2.height 
        AND p1.position = p2.position



--���67�F�e�|�W�V�������ƁiGK�AFW�Ȃǁj�ɍł��g���ƁA���̑I�薼��\�����Ă��������B�������ASELECT��ɕ��⍇�����g�p���Ă��������B
SELECT
    p1.position
    , MAX(p1.height) AS �ő�g��
    , ( 
        SELECT
            p2.name 
        FROM
            players p2 
        WHERE
            MAX(p1.height) = p2.height 
            AND p1.position = p2.position
    ) AS ���O 
FROM
    players p1 
GROUP BY
    p1.position



--���68�F�S�I��̕��ϐg�����Ⴂ�I������ׂĒ��o���Ă��������B�\�������́A�w�ԍ��A�|�W�V�����A���O�A�g���Ƃ��Ă��������B
select
    uniform_num
    , position
    , name
    , height 
from
    players 
where
    height < (select avg(height) from players)



--���69�F�e�O���[�v�̍ŏ�ʂƍŉ��ʂ�\�����A���̍���50���傫���O���[�v�𒊏o���Ă��������B
SELECT
    group_name
    , MAX(ranking)
    , MIN(ranking) 
FROM
    countries 
GROUP BY
    group_name 
HAVING
    MAX(ranking) - MIN(ranking) > 50



--���70�F1980�N���܂�ƁA1981�N���܂�̑I�肪���l���邩���ׂĂ��������B�������A���t�֐��͎g�p�����AUNION����g�p���Ă��������B
SELECT
    '1980' AS �a���N
    , COUNT(id) 
FROM
    players 
WHERE
    birth BETWEEN '1980-1-1' AND '1980-12-31' 
UNION 
SELECT
    '1981'
    , COUNT(id) 
FROM
    players 
WHERE
    birth BETWEEN '1981-1-1' AND '1981-12-31'



--���71�F�g����195�p���傫�����A�̏d��95kg���傫���I��𒊏o���Ă��������B�������A�ȉ��̉摜�̂悤�ɁA�ǂ���̏����ɂ����v����ꍇ�ɂ�2�����̃f�[�^�Ƃ��Ē��o���Ă��������B�܂��A���ʂ�id�̏����Ƃ��Ă��������B
SELECT
    id
    , position
    , name
    , height
    , weight 
FROM
    players 
WHERE
    height > 195 
UNION ALL 
SELECT
    id
    , position
    , name
    , height
    , weight 
FROM
    players 
WHERE
    weight > 95 
ORDER BY
    id



--���P�F���Җ����u��؉Ԏq�v�ł��銳�҂́A�ł��V�����f�@�L�^�̐f�@ID�A�f�@���A��t���A�f�ÉȖ���\������SQL�����쐬���Ă��������B
SELECT s.examination_id, s.examination_date, d.doctor_name, dp.department_name 
FROM examinations s
JOIN patients p ON s.patient_id = p.patient_id 
JOIN doctors d ON s.doctor_id = d.doctor_id 
JOIN departments dp ON d.department_id = dp.department_id 
WHERE p.patient_name = '��؉Ԏq' 
LIMIT 1;



--���2�F�e�f�ÉȂ��Ƃɐf�@�񐔂��W�v���āA�f�ÉȖ��Ɛf�@�񐔂��~���ŕ\������SQL�����쐬���Ă��������B
SELECT departments.department_name, COUNT(*) AS count
FROM examinations
INNER JOIN departments
ON examinations.department_id = departments.department_id
GROUP BY departments.department_name
ORDER BY count DESC;


--���R�F��t�����u�R�c��Y�v�ł��銳�҂�ID�Ɗ��Җ���\������SQL�����쐬���Ă��������B
SELECT patients.patient_id, patients.patient_name
FROM patients
INNER JOIN examinations
ON patients.patient_id = examinations.patient_id
INNER JOIN doctors
ON examinations.doctor_id = doctors.doctor_id
WHERE doctors.doctor_name = '�R�c��Y';



--���S�F�f�ÉȂ��u���ȁv���f�@����2022�N4��1���ȍ~�ł��銳�҂̊��Җ��Ɛf�@���������ŕ\������SQL�����쐬���Ă��������B
select p.patient_name, e.examination_date from patients p
inner join examinations e on e.patient_id = p.patient_id
inner join departments d on d.department_id = e.department_id
where d.department_name = '����' and e.examination_date >='2022-04-01'
order by e.examination_date ASC;



--���5:��t�����u�c���O�Y�v�ł���f�@�L�^�̐f�@ID�Ɛf�@����\������SQL�����쐬���Ă��������B
SELECT e.examination_id, e.examination_date
FROM doctors d
INNER JOIN examinations e
ON d.doctor_id = e.doctor_id
WHERE d.doctor_name = '�c���O�Y';



--���6:examinations�e�[�u������d��������������(patient_id)�̐���SQL�����쐬���Ă��������B
select distinct patient_id from examinations 



--���V�Fdepartment_id��2�̉�(department)�ɂ�����d��������������(patient_id)�̐���SQL�����쐬���Ă��������B
SELECT COUNT(DISTINCT patient_id) FROM examinations WHERE department_id = 2;



--���8�Fpatient_name��"�R�c���Y"�̊��҂̏����擾����N�G���������Ă��������B
SELECT * from patients p where p.patient_name = '�R�c���Y';



--���9.2022�N1��1���ȍ~�ɐf�@���ꂽ�S�Ă̏����擾����N�G���������Ă��������B
SELECT * FROM examinations e where e.examination_date >= '2022-1-1'



--���P�O�Fpatients�e�[�u������Apatient_id�������ł���gender�͒j���̊��҂̖��O���擾����SQL�����쐬���Ă��������B
SELECT p.patient_name FROM patients p where p.patient_id % 2 =0 and p.gender = '�j��'



--���11�Fdoctors�e�[�u������Asalary��400000�ȏ�ł���gender��'����'�̈�t��ID�Ɩ��O���擾����SQL�����쐬���Ă��������B
SELECT d.doctor_id, d.doctor_name FROM doctors d where d.salary >= '400000' and d.gender = '����'



--���P�Q�Fdepartment_id��1�܂���2�̊��҂̎��Ãf�[�^���擾����SQL�����쐬���Ă��������B
SELECT * FROM departments d join examinations e on e.department_id = d.department_id 
where d.department_id = '1' or d.department_id = '2'



--���P�R�F���҂�ID��6�ȏ�ŁA�f�f���ʂ�"���A�a"�܂���"������"�ł���f�f�f�[�^���擾����SQL�����쐬���Ă��������B
SELECT * FROM examinations e where e.patient_id >= '6' and 
(e.diagnosis = '���A�a' or e.diagnosis = '������')



--���P�S�Fpatient_id��3�܂���4�̏ꍇ�ŁA���Adiagnosis��"�}��������"�܂���"����"���܂܂�郌�R�[�h�𒊏o����SQL�����쐬���Ă��������B
SELECT * FROM examinations e where (e.patient_id = '3' or e.patient_id = '4') and 
(e.diagnosis = '�}��������' or e.diagnosis = '����')



--���P�T�Fpatient_id��5�ŁA���A(doctor_id��8�ł��邩�Adepartment_id��4�ł���)�A���Aexamination_date��2022�N11��05������̃��R�[
--          �h�𒊏o����SQL�����쐬���Ă��������B
SELECT * FROM examinations
WHERE patient_id = '5' AND ((doctor_id = '8' OR department_id = '4') AND examination_date > '2022-11-05');



--���16�Fexamination_date�������ŕ��בւ������ʂ��擾����SQL���������Ă��������B
SELECT * FROM examinations ORDER BY examination_date ASC;



--���17:diagnosis��"����"�̃��R�[�h��treatment�̍~���ŕ��בւ������ʂ��擾����SQL���������Ă��������B
SELECT * FROM examinations WHERE diagnosis = '����'ORDER BY treatment DESC;



--���18�F�ŏ���5�̊��҂�ID�Ɩ��O���擾����SQL���������Ă��������B
SELECT patient_id, patient_name
FROM patients
LIMIT 5;



--���19�F���҂̐f�@�f�[�^�ŁA�f�f���u���ׁv�ƂȂ��Ă���ŏ���10���̃f�[�^���擾����SQL���������Ă��������B
SELECT *
FROM examinations
WHERE diagnosis = '����'
LIMIT 10;



--���Q�O�Fexaminations�e�[�u������A����ID��1�ł���f�[�^�̂����A�ł��Â����t�ł���examination_date�ŕ��ёւ�����ŁA2�Ԗڂ̃��R�[�h����4�̃��R�[�h���擾���Ă��������B
SELECT *
FROM examinations
WHERE patient_id = 11
ORDER BY examination_date ASC
LIMIT 3 OFFSET 1;



--���21."��"�Ŏn�܂�diagnosis�������҂�I������SQL���������Ă��������B
SELECT * FROM examinations
WHERE diagnosis LIKE '��%';



--���22."����������"�Ƃ����P����܂�diagnosis�������҂�I������SQL���������Ă��������B
SELECT *FROM examinations WHERE diagnosis LIKE '����������';



--23.���Âɂ��Ď��z��\��悤�Ɏw���ŏI���patient_id�������҂�I������SQL���������Ă��������B
SELECT * FROM examinations WHERE treatment like '���Âɂ��Ď��z��\��悤�Ɏw��';



--24.patient_id��3�A5�A8�A10�̊��҂̑S�f�f�����擾����SQL�N�G�����쐬���Ă��������B
SELECT *
FROM examinations
WHERE patient_id IN (3, 5, 8, 10);



--25.����ID��2, 4, 6, 8�̂����ꂩ�ł���f�@���R�[�h���������Ă��������B�������A�f�@�Ȃ� '������' �ł�����̂Ɍ��肵�܂��B
select
    * 
from
    examinations e join departments d 
        on d.department_id = e.examination_id 
where
    e.patient_id IN (3, 5, 8, 10) 
    and d.department_name like '������';



--26.�f�@����2022�N3��15���܂���5��20���ł���A�f�@�Ȃ� '�O��' �܂��� '����' �̂����ꂩ�ł���f�@��
--�R�[�h���������Ă��������B�������A����ID��4�ł�����̂͏��O���܂��B
SELECT * FROM examinations WHERE (examination_date = '2022/03/15' OR examination_date = '2022/05/20')
AND department_id IN (SELECT department_id FROM departments WHERE department_name IN ('�O��', '����'))
AND patient_id NOT IN (4);

SELECT *
FROM examinations e
JOIN departments d ON e.department_id = d.department_id
WHERE e.examination_date IN ('2022/03/15', '2022/05/20')
AND d.department_name IN ('�O��', '����')
AND e.patient_id <> 4;



--27.��������2022�N3������2022�N5���̊Ԃɂ��銳�҂̂����A�a�@�̊O���Őf�@���ꂽ���҂̌���ID�Ɛf�f���ʂ��擾����B
select e.examination_id, e.diagnosis from examinations e where e.examination_date between '2022-03-01' and '2022-05-31'



--28.��������2022�N3������5���̊Ԃɂ��銳�҂ŁA�f�f���ʂɁu�ݒ�ᇁv�Ƃ��������񂪊܂܂�Ă��銳��
--�̌���ID�A����ID�A��tID�A�f�f���ʂ��擾����B
select e.examination_id, e.patient_id, e.doctor_id, e.diagnosis from examinations e where e.examination_date
 between '2022-03-01' and '2022-05-31'
and e.diagnosis like '�ݒ��';



--29.���Җ��A���ʁA�f�f�A���ÁA����ш�t�����܂ށA���ׂĂ̊��҂̏ڍׂƂ��̈�t�̏����擾����SQL�����쐬���Ă��������B
select p.patient_name, p.gender, e.diagnosis, d.doctor_name from examinations e join patients p on p.patient_id = e.patient_id
join doctors d on d.doctor_id = e.doctor_id ;



--30.�e�f�ÉȂ̐f�f�̐����܂ށA�f�ÉȖ��Ɛf�f����\������SQL�����쐬���Ă��������B
select d.department_name,count(e.examination_id) from examinations e join departments d on d.department_id = e.department_id 
group by d.department_name



--31.��t�̏��Ɛf�f�����������A�f�f���� "����������" �ł��銳�҂̎����Ɛf�f����\������N�G���B
select p.patient_name, e.examination_date from doctors d join examinations e on d.doctor_id = e.doctor_id 
join patients p on p.patient_id = e.patient_id
where e.diagnosis LIKE '����������'



--32.����̉Ȃɏ��������t�ƁA���̈�t���f�f�������҂̎����Ɛf�f����\������N�G���B
SELECT p.patient_name, e.diagnosis, d.doctor_name as ��t
FROM patients p
INNER JOIN examinations e ON p.patient_id = e.patient_id
INNER JOIN doctors d ON e.doctor_id = d.doctor_id
INNER JOIN departments dep ON d.department_id = dep.department_id
WHERE dep.department_name = '�O��';



--33.���҂��ƂɁA�ނ炪�Ō�Ɏ󂯂������̏��ƁA���̌������s������t�̏���\������B
--���i�������҂��܂��������󂯂Ă��Ȃ��ꍇ�́ANULL�l���\�����Ă��������B�j
SELECT p.patient_name, e.examination_date, d.doctor_name, de.department_name
FROM patients p
LEFT JOIN (
  SELECT examination_id, patient_id, doctor_id, department_id, examination_date
  FROM examinations e1
  WHERE NOT EXISTS (
    SELECT 1 
    FROM examinations e2
    WHERE e1.patient_id = e2.patient_id AND e1.examination_date < e2.examination_date
  )
) e ON p.patient_id = e.patient_id
LEFT JOIN doctors d ON e.doctor_id = d.doctor_id
LEFT JOIN departments de ON e.department_id = de.department_id;



----34.�e���傲�ƂɁA���̕���œ�����t�̕��ϋ��^�ƁA���̕���ōs��ꂽ�����̐���\������B
--������Ɉ�t�����Ȃ��ꍇ�́A���ϋ��^��NULL�l�Ƃ��ĕ\�����Ă��������B�܂��A����Ɍ�����
--�s���Ă��Ȃ��ꍇ�́A��������0�Ƃ��ĕ\�����Ă�������
SELECT de.department_name, AVG(d.salary) AS avg_salary, COUNT(e.examination_id) AS num_exams
FROM departments de
LEFT JOIN doctors d ON de.department_id = d.department_id
LEFT JOIN examinations e ON de.department_id = e.department_id
GROUP BY de.department_id;



--35.departments�e�[�u����doctors�e�[�u����department_id�Ō������A�e�����̕��ϋ��^���擾����SQL�����쐬���Ă��������B
SELECT departments.department_name, AVG(doctors.salary) AS avg_salary
FROM departments
LEFT JOIN doctors
ON departments.department_id = doctors.department_id
GROUP BY departments.department_name;



--36.patients�e�[�u����examinations�e�[�u����patient_id�Ō������A�f�@���󂯂����҂̑����ƍŐV�̐f�@�����擾����SQL�����쐬���Ă��������B
SELECT patients.patient_name, COUNT(examinations.examination_id) AS total_examinations, MAX(examinations.examination_date) AS latest_examination
FROM patients
LEFT JOIN examinations
ON patients.patient_id = examinations.patient_id
GROUP BY patients.patient_name;



--37.��t�̏����A�������镔���̏�񂪂���ꍇ�͂�����܂߂ĕ\������SQL�����쐬���Ă��������B
select * from departments dep left join doctors d on d.department_id = dep.department_id



--38.�����̏����A���҂̏�񂪂���ꍇ�͂�����܂߂ĕ\������SQL�����쐬���Ă��������B
select * from patients p right join examinations e on e.patient_id = p.patient_id



--39.patients�e�[�u����examinations�e�[�u����LEFT JOIN���A�e���҂��ł��ŋߍs���������̏����擾����N�G�����쐬���Ă��������B
select p.patient_name, max(e.examination_date) from patients p left join examinations e on p.patient_id = e.patient_id group by
p.patient_name



--40.doctors�e�[�u����departments�e�[�u����LEFT JOIN���A�e�Ȃ̕��ϋ��^�ƍŒዋ�^���擾����N�G�����쐬���Ă��������B
select dep.department_name, AVG(d.salary), min(d.salary) from doctors d left join departments dep on d.department_id = dep.department_id
group by dep.department_name



--41.��҂̖��O�A���҂̖��O�A�f�f�A���Ó��e�A����ѐf�@�����܂ރ��|�[�g���쐬���Ă��������B�������A��҂Ɗ��҂��Ƃ��ɑ��݂��A�f�f�Ǝ��Ó��e
--����łȂ��ꍇ�ɂ̂݁A���|�[�g�Ɋ܂߂Ă��������B���|�[�g�́A�f�@�����V�������̂���Â����̂̏��ɕ��בւ���K�v������܂��B
SELECT d.doctor_name, p.patient_name, e.diagnosis, e.treatment, e.examination_date 
FROM examinations e 
JOIN patients p ON e.patient_id = p.patient_id 
JOIN doctors d ON d.department_id = e.department_id 
WHERE e.diagnosis <> '' AND e.treatment <> ''
ORDER BY e.examination_date DESC;


SELECT doctors.doctor_name, patients.patient_name, examinations.diagnosis, examinations.treatment, examinations.examination_date
FROM doctors
INNER JOIN examinations ON doctors.doctor_id = examinations.doctor_id
INNER JOIN patients ON examinations.patient_id = patients.patient_id
WHERE examinations.diagnosis <> '' AND examinations.treatment <> ''
ORDER BY examinations.examination_date DESC;



--42.���ҁipatients�j�ƈ�t�idoctors�j�̏����������āA�����idepartments�j���Ƃ̕��ϋ��^�isalary�j��\������N�G�����쐬���Ă��������B
--�������A�������idepartment_name�j�� '����' �̕����͏��O���Ă��������B
SELECT d.department_id, d.department_name, AVG(salary) as avg_salary
FROM departments d
INNER JOIN doctors doc ON doc.department_id = d.department_id
INNER JOIN patients p ON p.gender = doc.gender
WHERE d.department_name <> '����'
GROUP BY d.department_id, d.department_name;



--43.���ҁipatients�j�ƌ����iexaminations�j�̏����������āA���Җ��ipatient_name�j�ƌ������iexamination_date�j
--���Ƃ̈�t����\������N�G�����쐬���Ă��������B
--�������A���Җ��ƌ������̑g�ݍ��킹�����݂��Ȃ��ꍇ�́A0��\�����Ă��������B
SELECT p.patient_name, e.examination_date, COUNT(doc.doctor_id) AS doctor_count
FROM patients p
LEFT JOIN examinations e ON p.patient_id = e.patient_id
LEFT JOIN doctors doc ON doc.doctor_id = e.doctor_id
GROUP BY p.patient_name, e.examination_date;



--44.���҂ƈ�t�̏����ȂƂ��̉Ȃ̐����̏�����������SQL�����쐬����
select p.patient_name,d.department_name,d.description from examinations e join patients p on e.patient_id = p.patient_id
join departments d on d.department_id = e.department_id



--45.���҂̐��ʂƔN����A��t�̐��ʂ���������SQL�����쐬���Ă��������B
SELECT p.patient_name, p.gender as patient_gender, p.date_of_birth as patient_dob, d.doctor_name, d.gender as doctor_gender, date_part('year',age(current_date, to_date(p.date_of_birth, 'YYYY-MM-DD'))) as patient_age
FROM patients p
INNER JOIN examinations e ON p.patient_id = e.patient_id
INNER JOIN doctors d ON e.doctor_id = d.doctor_id;



--46.�S���҂̒��ŁA�f�f���ꂽ�a�C�̐����ł������g�b�v5�̊��҂��擾���邽�߂̃N�G�����쐬���Ă��������B
--�������A�f�f���Ȃ����҂͌��ʂɊ܂߂Ȃ��ł��������B
SELECT p.patient_name, COUNT(*) AS num_diagnoses
FROM patients p
INNER JOIN examinations e ON p.patient_id = e.patient_id
WHERE e.diagnosis IS NOT NULL
GROUP BY p.patient_name
ORDER BY num_diagnoses DESC
LIMIT 5;



--47.��t���ƂɁA���̈�t���f�@�������҂̖��O�A���ʁA�f�@���A�f�f�A����ю��Â��擾���邽�߂̃N�G�����쐬���Ă��������B
--�������A�S�Ă̈�t�̏����擾����K�v������܂��B
SELECT d.doctor_name, p.patient_name, p.gender, e.examination_date, e.diagnosis, e.treatment
FROM doctors d
LEFT JOIN examinations e ON d.doctor_id = e.doctor_id
LEFT JOIN patients p ON e.patient_id = p.patient_id;



--48.��t�̕��ϋ��^�����߂�
SELECT AVG(salary) AS avg_salary FROM doctors;



--49.�������Ƃ̈�t�̕��ϋ��^�����߂�
SELECT departments.department_name, AVG(doctors.salary) as avg_salary
FROM departments
INNER JOIN doctors ON departments.department_id = doctors.department_id
GROUP BY departments.department_name;



--50.�S���҂̕��ϔN������߂�
SELECT AVG(EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM TO_DATE(patients.date_of_birth, 'YYYY-MM-DD'))) AS avg_age
FROM patients;



--51.examinations�e�[�u���ɓo�^���ꂽ�A�e���҂̐f�@�񐔂����߂�SQL�����쐬���Ă��������B
SELECT patient_name, COUNT(*) as examination_count
FROM patients
INNER JOIN examinations ON patients.patient_id = examinations.patient_id
GROUP BY patient_name;



--52.���҂̐����J�E���g����SQL�����쐬���Ă��������B
SELECT COUNT(patient_id) as patient_count FROM patients;



--53.�e�Ȃ̈�t�����J�E���g����SQL�����쐬���Ă��������B
SELECT COUNT(d.doctor_id) FROM doctors d;



--54.�e���҂̍ł��Â����������擾����B
SELECT patients.patient_name, MIN(examination_date) AS old_examination_date
FROM examinations inner join patients on examinations.patient_id = patients.patient_id
GROUP BY patient_name;



--55.�Œዋ��������t��������B
select d.doctor_name, min(d.salary) from doctors d group by doctor_name



--56.��t�̍ō����^����������SQL�����쐬���Ă��������B
SELECT MAX(salary) AS max_salary FROM doctors;



--57.�e�f�ÉȂ̈�t�̍ō����^����������SQL�����쐬���Ă��������B
SELECT departments.department_name, MAX(doctors.salary) AS max_salary
FROM departments
INNER JOIN doctors ON departments.department_id = doctors.department_id
GROUP BY departments.department_name;



--58.�e���҂̍ŐV�̐f�f����������SQL�����쐬���Ă��������B
SELECT patients.patient_name, examinations.diagnosis, MAX(examinations.examination_date) AS latest_diagnosis_date
FROM patients
INNER JOIN examinations ON patients.patient_id = examinations.patient_id
GROUP BY patients.patient_name, examinations.diagnosis;



--59.�e����̈�t�̕��ϋ��^�Ƒ��x���z���v�Z����SQL�����쐬���Ă��������B
select d.doctor_name, avg(d.salary),sum(d.salary) from doctors d group by d.doctor_name



--60.�u���ȁv���������t�̋��^���z���v�Z����SQL�����쐬���Ă��������B
SELECT departments.department_name, SUM(doctors.salary) AS total_salary
FROM departments
INNER JOIN doctors
ON departments.department_id = doctors.department_id
WHERE departments.department_name = '����'
GROUP BY departments.department_name;



--61.�e����̕��ϋ��^���擾����SQL�����쐬���Ă��������B
SELECT department_id, AVG(salary) as avg_salary
FROM doctors
GROUP BY department_id;



--62.�e���҂��󂯂��f�@�̐����擾����SQL�����쐬���Ă��������B
SELECT patient_id, COUNT(*) as exam_count
FROM examinations
GROUP BY patient_id;



--63.�e�����̕��ϋ��^�ƍō����^���擾����N�G�����쐬���Ă��������B
SELECT departments.department_name, AVG(doctors.salary) as avg_salary, MAX(doctors.salary) as max_salary
FROM doctors
INNER JOIN departments ON doctors.department_id = departments.department_id
GROUP BY departments.department_name;



--64.���҂��Ƃ̍Ō�̌����̐f�f���擾����SQL�����쐬���Ă��������B
SELECT p.patient_name, e.diagnosis 
FROM patients p
JOIN examinations e ON p.patient_id = e.patient_id
WHERE e.examination_date = (
  SELECT MAX(examination_date) 
  FROM examinations 
  WHERE patient_id = p.patient_id
);



--65.�e�f�ÉȂ̈�t�̊��Ґ��ƁA���̊��҂����̕��ϔN������߂�B
--�������A�e�f�ÉȂ̈�t��1���ȏ㏊�����Ă�����̂Ƃ���B
--�܂��A���ϔN��͏����_�ȉ�2���܂ŕ\��������̂Ƃ���B
SELECT 
  d.department_name, 
  COUNT(DISTINCT e.patient_id) AS patient_count, 
  ROUND(AVG(EXTRACT(YEAR FROM age(to_date(p.date_of_birth, 'YYYY-MM-DD')))), 2) AS avg_age 
FROM 
  departments d 
  JOIN doctors doc ON d.department_id = doc.department_id 
  JOIN examinations e ON doc.doctor_id = e.doctor_id 
  JOIN patients p ON e.patient_id = p.patient_id 
GROUP BY 
  d.department_name 
HAVING 
  COUNT(DISTINCT e.patient_id) > 0;
  
  
  
--66.���҂��Ƃ̍ł��V�����������ʂ��擾����SQL�����쐬���Ă�������.
SELECT p.patient_name, e.examination_date, e.diagnosis, e.treatment
FROM patients p
INNER JOIN examinations e ON p.patient_id = e.patient_id
WHERE (e.examination_date, p.patient_id) IN (
  SELECT MAX(examination_date), patient_id
  FROM examinations
  GROUP BY patient_id
)
ORDER BY e.examination_date DESC;



--67.���傲�Ƃɍł��������^������t�̏����擾����SQL�����쐬���Ă�������.
SELECT departments.department_name, d.doctor_name, d.salary
FROM (
  SELECT department_id, MAX(salary) AS max_salary
  FROM doctors
  GROUP BY department_id
) m
INNER JOIN doctors d ON m.department_id = d.department_id 
INNER JOIN departments ON departments.department_id = d.department_id
AND m.max_salary = d.salary;



--68.���҂��ƂɁA�f�f���ꂽ�����̈ꗗ���܂ޏڍׂȈ�Ã��|�[�g�𐶐�����N�G�����쐬���Ă��������B  
  SELECT 
  p.patient_name,
  p.gender,
  p.date_of_birth,
  p.address,
  p.phone_number,
  e.examination_date,
  d.department_name,
  doc.doctor_name,
  e.diagnosis,
  e.treatment
FROM 
  patients p
  JOIN examinations e ON p.patient_id = e.patient_id
  JOIN doctors doc ON e.doctor_id = doc.doctor_id
  JOIN departments d ON e.department_id = d.department_id
  
  
  
--69.���҂��Ƃ́A�ł��ŋ߂̐f�@���ʂ�\������N�G���B���҂��܂��f�@���󂯂Ă��Ȃ��ꍇ�́A�f�@����null�ƂȂ�悤�ɕ\������B
SELECT 
    patients.patient_id, 
    patients.patient_name, 
    MAX(examinations.examination_date) AS latest_examination_date, 
    CASE 
        WHEN COUNT(examinations.examination_date) = 0 THEN NULL 
        ELSE MAX(examinations.diagnosis) 
    END AS latest_diagnosis, 
    CASE 
        WHEN COUNT(examinations.examination_date) = 0 THEN NULL 
        ELSE MAX(examinations.treatment) 
    END AS latest_treatment 
FROM 
    patients 
LEFT JOIN 
    examinations 
ON 
    patients.patient_id = examinations.patient_id
GROUP BY 
    patients.patient_id
ORDER BY
    patients.patient_id;
    
    
    
--70.�e����̕��ϋ��^�ƁA���ϋ��^���ł���������̖��O�ƕ��ϋ��^��\������B   
SELECT
    departments.department_name
    , AVG(doctors.salary) AS avg_salary 
FROM
    doctors JOIN departments 
        ON doctors.department_id = departments.department_id 
GROUP BY
    departments.department_name 
ORDER BY
    avg_salary DESC 
LIMIT 1;



--71.���Җ��A���ʁA���N�����A�f�f�A���ÁA�f�Ó����܂ށA����f�ÉȂ�'����'�ɏ������邷�ׂĂ̊��҂̏ڍׂ��擾����SQL�N�G��
SELECT p.patient_name, p.gender, p.date_of_birth, e.diagnosis, e.treatment, e.examination_date 
FROM patients p 
INNER JOIN examinations e ON p.patient_id = e.patient_id 
INNER JOIN doctors d ON e.doctor_id = d.doctor_id 
INNER JOIN departments dep ON d.department_id = dep.department_id 
WHERE dep.department_name = '����';



--72.�f�f��'�݉�'���܂ފ��҂̑������擾����SQL�����쐬���Ă��������B
SELECT COUNT(DISTINCT e.patient_id) as total_patients 
FROM examinations e 
WHERE e.diagnosis LIKE '%�݉�%';



--73.�e���҂��ŋߎ󂯂��f�f�̃��X�g���擾����SQL�����쐬���Ă��������B
SELECT 
  patients.patient_name, 
  examinations.examination_date, 
  examinations.diagnosis 
FROM 
  patients 
  JOIN examinations ON patients.patient_id = examinations.patient_id 
WHERE 
  (examinations.patient_id, examinations.examination_date) IN 
    (SELECT 
      patient_id, MAX(examination_date) 
    FROM 
      examinations 
    GROUP BY 
      patient_id) 
ORDER BY 
  examinations.examination_date DESC;
  
  
  
--74.�e�f�ÉȂ̈�t�̕��ϋ��^�ƍō����^���擾����SQL�����쐬���Ă��������B
SELECT 
  departments.department_name, 
  AVG(doctors.salary) AS avg_salary, 
  MAX(doctors.salary) AS max_salary 
FROM 
  departments 
  JOIN doctors ON departments.department_id = doctors.department_id 
GROUP BY 
  departments.department_name;
  
  
  
--75.���҂̒j��������߂�SQL�����쐬���Ă�������
SELECT gender, COUNT(*) as �l��
FROM patients
GROUP BY gender;



--76.�e�f�ÉȂ̈�t�������߂�SQL�����쐬���Ă�������
SELECT departments.department_name, COUNT(doctors.doctor_id) as ��t��
FROM departments
LEFT JOIN doctors ON departments.department_id = doctors.department_id
GROUP BY departments.department_id;



--77.���҂��󂯂��f�@�����̈ꗗ���擾����SQL�����쐬���Ă�������
SELECT examinations.examination_date, doctors.doctor_name, departments.department_name, examinations.diagnosis, examinations.treatment
FROM examinations
JOIN doctors ON examinations.doctor_id = doctors.doctor_id
JOIN departments ON examinations.department_id = departments.department_id



--78.�}���V�����̕��ω��i�����߂�SQL���������Ă��������B
SELECT AVG(price) AS average_price
FROM Property
WHERE property_type = '�}���V����';



--79.���p�萔�����ł������_��̕������A���p�Җ��A�s���Y��Ж��A�萔�������߂�SQL���������Ă��������B
SELECT p.property_name, sc.buyer_name, rc.company_name, MAX(c.commission_fee) AS commission_fee
FROM SaleContract AS sc
INNER JOIN Commission AS c ON sc.contract_id = c.contract_id
INNER JOIN Property AS p ON sc.property_id = p.property_id
INNER JOIN RealEstateCompany AS rc ON c.company_id = rc.company_id
GROUP BY p.property_name, sc.buyer_name, rc.company_name
ORDER BY commission_fee DESC
LIMIT 1;



--80.�������Ɂu�p�[�N�v���܂܂�镨���̏����A�������̃A���t�@�x�b�g���ɕ��ׂĎ擾����SQL���������Ă��������B
SELECT *
FROM Property
WHERE property_name LIKE '%�p�[�N%'
ORDER BY property_name ASC;



--81.2022�N�Ɍ_�񂳂ꂽ�����̂����A���i��1���~�ȏ�̎�������ƍ��v���z�����߂�SQL���������Ă��������B
SELECT COUNT(*) AS total_count, SUM(price) AS total_price
FROM SaleContract
WHERE price >= 100000000 AND SaleContract.contract_date = 2022;



--82.�����s�ɂ��镨���̈ꗗ�ƁA���ꂼ��̕����ɂ��Ẳ摜�t�@�C������\������
SELECT Property.property_name, Property.address, PropertyImage.image_file_name
FROM Property
INNER JOIN PropertyImage ON Property.property_id = PropertyImage.property_id
WHERE Property.address LIKE '�����s%';



--83.�s���Y���B���萔���𓾂����z���A�萔���̑��z�ƂƂ��ɕ\������
SELECT RealEstateCompany.company_name, SUM(Commission.commission_fee) AS total_commission
FROM Commission
INNER JOIN RealEstateCompany ON Commission.company_id = RealEstateCompany.company_id
WHERE RealEstateCompany.company_name = '�s���Y���B'
GROUP BY company_name;



--84.2022�N�Ɍ_�񂳂ꂽ�����̈ꗗ���A�_������ɕ��ׂĕ\������
select S.property_id, P.property_name from SaleContract S join Property P on P.property_id = S.property_id order by S.contract_date;



--85.�s���Y���A�����p���������̒��ŁA�ł��������i�̕�������������
SELECT Property.property_name, Property.price
FROM Property
INNER JOIN SaleContract ON Property.property_id = SaleContract.property_id
INNER JOIN Commission ON SaleContract.contract_id = Commission.contract_id
INNER JOIN RealEstateCompany ON Commission.company_id = RealEstateCompany.company_id
WHERE RealEstateCompany.company_name = '�s���Y���A'
ORDER BY Property.price DESC
LIMIT 1;



--86.�������Ɂu�p�[�N�n�E�X�v�Ƃ��������񂪊܂܂�镨���̒��ŁA�w���҂��u�����^���v�ł���_��̌_����Ǝ萔�����擾����SQL�����쐬���Ă��������B
SELECT contract_date, commission_fee
FROM SaleContract
JOIN Commission ON SaleContract.contract_id = Commission.contract_id
JOIN Property ON SaleContract.property_id = Property.property_id
WHERE Property.property_name LIKE '%�p�[�N�n�E�X%'
AND SaleContract.buyer_name = '�����^��';



--87.�s���Y���B���萔�����󂯎�����_��̒��ŁA�_������ł��V�����_��̍w���Җ��ƕ��������擾����SQL�����쐬���Ă��������B
SELECT buyer_name, property_name
FROM SaleContract
JOIN Property ON SaleContract.property_id = Property.property_id
WHERE SaleContract.contract_id IN (
  SELECT contract_id 
  FROM Commission
  WHERE company_id = 2
)
ORDER BY contract_date DESC
LIMIT 1;



--88.�������Y���w�����������̏����擾����SQL�����쐬���Ă��������B
SELECT * FROM Property 
INNER JOIN SaleContract ON Property.property_id = SaleContract.property_id 
WHERE SaleContract.buyer_name = '�������Y';



--89.�e�s���Y��Ђ��󂯎�����萔���̍��v���z���擾����SQL�����쐬���Ă��������B
SELECT company_name, SUM(commission_fee) FROM RealEstateCompany 
INNER JOIN Commission ON RealEstateCompany.company_id = Commission.company_id 
GROUP BY company_name;



--90.�I�t�B�X�r���̕��ω��i���擾����SQL�����쐬���Ă��������B
SELECT AVG(price) FROM Property 
WHERE property_type = '�I�t�B�X�r��';



--91.�_������ŐV�̌_������擾����SQL�����쐬���Ă��������B
SELECT * FROM SaleContract 
WHERE contract_date = (SELECT MAX(contract_date) FROM SaleContract);



----92.��ˌ��Ă̕�����̔������s���Y��Ђ̖��O�Ƃ��̔̔��������擾����SQL�����쐬���Ă��������B
SELECT company_name, COUNT(*) FROM RealEstateCompany 
INNER JOIN Commission ON RealEstateCompany.company_id = Commission.company_id 
INNER JOIN SaleContract ON Commission.contract_id = SaleContract.contract_id 
INNER JOIN Property ON SaleContract.property_id = Property.property_id 
WHERE Property.property_type = '��ˌ���' 
GROUP BY company_name;



----93.�s���Y���B�����p���������̒��ŁA�ł������萔�����󂯎�����_��̏����擾����SQL�����쐬���Ă��������B
SELECT * FROM Commission 
INNER JOIN SaleContract ON Commission.contract_id = SaleContract.contract_id 
WHERE Commission.company_id = 2 
ORDER BY commission_fee DESC 
LIMIT 1;



--94.2022�N�ɐ��������_��̌����Ƃ��̍��v���z���擾����SQL�����쐬���Ă��������B
SELECT COUNT(*), SUM(price) FROM SaleContract 
WHERE contract_date BETWEEN '2022-01-01' AND '2022-12-31';



----95.���p���i��1���~�ȏ�̕����̏����擾����SQL�����쐬���Ă��������B
SELECT * FROM Property 
INNER JOIN SaleContract ON Property.property_id = SaleContract.property_id 
WHERE SaleContract.price >= 100000000;



--96.�s���Y���A�����p�����s���Y�̌������擾����SQL�����쐬���Ă��������B
SELECT COUNT(*) FROM SaleContract 
INNER JOIN Commission ON SaleContract.contract_id = Commission.contract_id 
WHERE Commission.company_id = 1;


--97.�s���Y���C��2023�N�ɔ��p���������̂����A�萔�����ł��������̂̎萔�������߂�SQL���쐬���Ă��������B
SELECT MAX(commission_fee) AS �萔�����ł��������̂̎萔��
FROM Commission
WHERE contract_id IN (
    SELECT contract_id
    FROM SaleContract
    WHERE contract_date BETWEEN '2023-01-01' AND '2023-12-31'
        AND EXISTS (
            SELECT 1
            FROM RealEstateCompany
            WHERE RealEstateCompany.company_id = Commission.company_id
                AND RealEstateCompany.company_name = '�s���Y���C'
        )
);



--98.�I�[�V�����r���[�Ƃ����}���V�������w�������l�̖��O�ƍw������\������SQL���쐬���Ă��������B
SELECT buyer_name, contract_date
FROM SaleContract
WHERE property_id = (
    SELECT property_id
    FROM Property
    WHERE property_name = '�I�[�V�����r���['
        AND property_type = '�}���V����'
);



--99.�_�ސ쌧�ɂ����ˌ��Ă̕������Ɖ��i���A���i���������ɕ\������SQL���쐬���Ă��������B
SELECT property_name, price
FROM Property
WHERE property_type = '��ˌ���' AND address LIKE '�_�ސ쌧%'
ORDER BY price;



--100.�s���Y���B��2022�N�ɔ��p���������̑�����グ�����߂�SQL���쐬���Ă��������B
SELECT property_name, price
FROM Property
WHERE property_type = '�}���V����' AND address LIKE '%�����s%' AND price > 100000000;



--101.����̕s���Y��Ђ�����������_��̍��v�萔�������߂�SQL���������Ă��������B
SELECT SUM(c.commission_fee)
FROM Commission c
INNER JOIN SaleContract s ON c.contract_id = s.contract_id
WHERE c.company_id = '1';



--102.����̕����̏��Ƃ��̕�������舵���s���Y��Ђ̏����A����ID����ɂ��Ď擾����SQL���������Ă��������B
SELECT p.property_name, p.address, p.property_type, p.price,
       r.company_name, r.address, r.phone_number
FROM Property p
INNER JOIN RealEstateCompany r ON p.property_id = '2' AND r.company_id = p.property_id;



--103.����̕����̔����_����Ƃ��̌_��ɑ΂��钇��萔�����擾����SQL���������Ă��������B
SELECT s.contract_id, s.buyer_name, s.contract_date, s.price, c.commission_fee
FROM SaleContract s
INNER JOIN Commission c ON s.contract_id = c.contract_id
WHERE s.property_id = '3';



--104.����̕s���Y��Ђ���舵�������̏����A�s���Y���ID����ɂ��Ď擾����SQL���������Ă��������B
SELECT p.property_id, p.property_name, p.address, p.property_type, p.price
FROM Property p
INNER JOIN RealEstateCompany r ON p.property_id = r.company_id AND r.company_id = '2';



--105.����萔�����ő�ł��锄���_��̏��ƁA���̌_��ɑ΂��钇��萔�����擾����SQL���������Ă��������B
SELECT s.contract_id, s.property_id, s.buyer_name, s.contract_date, s.price, MAX(c.commission_fee) AS max_commission_fee
FROM SaleContract s
INNER JOIN Commission c ON s.contract_id = c.contract_id
WHERE c.commission_fee = (SELECT MAX(commission_fee) FROM Commission)
GROUP BY s.contract_id, s.property_id, s.buyer_name, s.contract_date, s.price;



--106.�����e�[�u���ɂ́A�����Z���ɕ����̕��������݂���\��������B���̏ꍇ�A�����e�[�u������Z�����Ƃɕ��������J�E���g����N�G�����쐬���Ă��������B
SELECT address, COUNT(*) AS property_count
FROM Property
GROUP BY address;



--107.�����e�[�u���Ɣ����_��e�[�u�����������A�������A�Z���A�_����A�w���Җ��A����є������i���܂ރ��|�[�g���쐬���Ă��������B
SELECT Property.property_name, Property.address, SaleContract.contract_date, SaleContract.buyer_name, SaleContract.price
FROM Property
INNER JOIN SaleContract
ON Property.property_id = SaleContract.property_id;



--108.�����e�[�u���ƕ����摜�e�[�u�����������A�������Ƃ̉摜���ƕ��������܂ރ��|�[�g���쐬���Ă��������B
SELECT Property.property_name, COUNT(*) AS image_count
FROM Property
INNER JOIN PropertyImage
ON Property.property_id = PropertyImage.property_id
GROUP BY Property.property_name;



--109.����萔���e�[�u���Ɣ����_��e�[�u�����������A�_�񂲂Ƃ̒���萔���Ɣ������i���܂ރ��|�[�g���쐬���Ă��������B
SELECT SaleContract.contract_id, Commission.commission_fee, SaleContract.price
FROM Commission
INNER JOIN SaleContract
ON Commission.contract_id = SaleContract.contract_id;



--110.�����e�[�u�����畨���̉��i���ł��������̂��擾����SQL�����쐬���Ă��������B
SELECT *
FROM Property
WHERE price = (SELECT MAX(price) FROM Property);



--111.�����_��e�[�u���ɂ���_���(contract_date)���ŋ߂̂��̂��珇��5���擾����SQL�����쐬���Ă��������B
SELECT *
FROM SaleContract
ORDER BY contract_date DESC
LIMIT 5;



--112.�����摜�e�[�u���ɂ���摜�t�@�C����(image_file_name)�� ".png" �ŏI��镨���̏����擾����SQL�����쐬���Ă��������B
SELECT
    Property.property_name
    , Property.address
    , Property.property_type
    , Property.price
    , PropertyImage.image_file_name 
FROM
    Property 
    inner join PropertyImage 
        on Property.property_id = PropertyImage.property_id
        
        
        
--113.�����e�[�u���ƕs���Y��Ѓe�[�u�����������āA�s���Y��Ђ��ƂɎ�舵���Ă��镨���̐����擾����SQL�����쐬���Ă��������B
SELECT c.company_id, c.company_name, COUNT(p.property_id) AS num_properties
FROM RealEstateCompany AS c
LEFT JOIN SaleContract AS s ON c.company_id = s.contract_id
LEFT JOIN Property AS p ON s.property_id = p.property_id
GROUP BY c.company_id, c.company_name;



--114.�����_��e�[�u���ɂ���e�_�񂲂Ƃ̒���萔�����A�s���Y��Ђ��Ƃɍ��v���Ď擾����SQL�����쐬���Ă��������B
SELECT c.company_id, c.company_name, SUM(cm.commission_fee) AS total_commission
FROM RealEstateCompany AS c
LEFT JOIN Commission AS cm ON c.company_id = cm.company_id
LEFT JOIN SaleContract AS s ON cm.contract_id = s.contract_id
GROUP BY c.company_id, c.company_name;



--115.�s���Y��Ѓe�[�u���ƒ���萔���e�[�u�����������āA��Ђ��Ƃ̒���萔���̕��ϒl�ƍő�l���v�Z����N�G�����쐬���Ă��������B
SELECT 
  r.company_name, 
  AVG(c.commission_fee) AS avg_commission_fee,
  MAX(c.commission_fee) AS max_commission_fee
FROM RealEstateCompany r
INNER JOIN Commission c ON r.company_id = c.company_id
GROUP BY r.company_name;



--116.�����e�[�u���ɂ���S�Ă̕����̒��ŁA�ł��������i�����������Ɖ��i���擾����N�G���B
SELECT property_name, price
FROM Property
WHERE price = (SELECT MAX(price) FROM Property)



--117.�����摜�e�[�u���ɕ����摜���o�^����Ă��镨���̐����擾����N�G���B
SELECT COUNT(DISTINCT property_id)
FROM PropertyImage



--118.�����_��e�[�u���ƕs���Y��Ѓe�[�u�����������A�s���Y��Ђ��Ƃ̑����㍂���擾����N�G���B
SELECT RealEstateCompany.company_name, SUM(SaleContract.price) as total_sales
FROM SaleContract
JOIN RealEstateCompany
ON SaleContract.contract_id = RealEstateCompany.company_id
GROUP BY RealEstateCompany.company_name ORDER BY RealEstateCompany.company_name



--119.�����e�[�u���Ɣ����_��e�[�u�����������A�e�������ƂɍŐV�̌_����ƌ_����z���擾����N�G���B
SELECT Property.property_name, MAX(SaleContract.contract_date) as latest_contract_date, SaleContract.price
FROM Property
LEFT JOIN SaleContract
ON Property.property_id = SaleContract.property_id
GROUP BY Property.property_name, SaleContract.price



--120.�����e�[�u���ƒ���萔���e�[�u�����������A�e�s���Y��Ђ��ƂɊl����������萔���̑��z���擾����N�G���B
SELECT RealEstateCompany.company_name, SUM(Commission.commission_fee) as total_commission
FROM RealEstateCompany
LEFT JOIN Commission
ON RealEstateCompany.company_id = Commission.company_id
GROUP BY RealEstateCompany.company_name



--121.�����e�[�u���ɂ��鉿�i���A���ω��i��荂�������̖��O�Ɖ��i���擾����N�G���B
SELECT property_name, price
FROM Property
WHERE price > (SELECT AVG(price) FROM Property)



--122.�����̎�ނ��Ƃ̕��ω��i�����߂�N�G���B
SELECT property_type, AVG(price) AS avg_price
FROM Property
GROUP BY property_type;



--123.�����̔̔���Ђ��Ƃ̔̔��������ƍ��v�萔�������߂�N�G���B
SELECT c.company_name, COUNT(s.contract_id) AS num_properties, SUM(co.commission_fee) AS total_commission
FROM RealEstateCompany c
INNER JOIN Commission co
ON c.company_id = co.company_id
INNER JOIN SaleContract s
ON co.contract_id = s.contract_id
GROUP BY c.company_name;



--124.�����摜�����݂��镨���̕������Ɖ摜�t�@�C���������߂�N�G���B
SELECT p.property_name, pi.image_file_name
FROM Property p
INNER JOIN PropertyImage pi
ON p.property_id = pi.property_id;



--125.�����̉��i�����ω��i��荂�������̕������Ɖ��i�����߂�N�G���B
SELECT property_name, price
FROM Property
WHERE price > (SELECT AVG(price) FROM Property);



--126.�������w���������傪1�l�ȏ�̕����̕������A�̔���Ж��A���喼�����߂�N�G���B
SELECT p.property_name, c.company_name, s.buyer_name
FROM Property p
INNER JOIN SaleContract s
ON p.property_id = s.property_id
INNER JOIN Commission co
ON s.contract_id = co.contract_id
INNER JOIN RealEstateCompany c
ON co.company_id = c.company_id
GROUP BY p.property_name, c.company_name, s.buyer_name
HAVING COUNT(s.buyer_name) >= 1;



--127.�����̉��i�̍ő�l�ƍŏ��l�����߂�N�G���B
SELECT MAX(price) AS max_price, MIN(price) AS min_price
FROM Property;



--128.�����𔄋p�����̔���Ђ̂����A���p���������ł�������Ђ����߂�N�G���B
SELECT c.company_name, COUNT(s.contract_id) AS num_properties
FROM RealEstateCompany c
INNER JOIN Commission co
ON c.company_id = co.company_id
INNER JOIN SaleContract s
ON co.contract_id = s.contract_id
GROUP BY c.company_name
ORDER BY COUNT(s.contract_id) DESC
LIMIT 1;



--129.�������w����������̂����A�ł������������w���������喼�Ƃ��̍w���������߂�N�G���B
SELECT buyer_name, COUNT(*) AS num_purchases
FROM SaleContract
GROUP BY buyer_name
ORDER BY COUNT(*) DESC
LIMIT 1;



--130.�����^�C�v���Ƃ̕�������\������N�G�����쐬���Ă��������B
SELECT property_type, COUNT(*) AS count
FROM Property
GROUP BY property_type;
