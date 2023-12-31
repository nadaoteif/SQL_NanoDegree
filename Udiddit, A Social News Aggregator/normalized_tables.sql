---------------------------------------------------
-- DATABASE TABLES
---------------------------------------------------
-- Create a table for users
CREATE​ ​TABLE​ ​"users"​(
"user_id"​ SERIAL PRIMARY ​KEY​,
"username"​ VARCHAR(​25​) ​NOT​ NULL ​CHECK​ (​LENGTH​(​TRIM​(​"username"​))>​0​),
"last_login"​ ​TIMESTAMP);


-- Create a table for topics
CREATE​ ​TABLE​ ​"topics"​(
"topic_id"​ SERIAL PRIMARY ​KEY​,
"topic_name"​ VARCHAR(​30)​ ​NOT​ NULL ​CHECK (​LENGTH​(​TRIM​(​"topic_name"​))>​0​),
"topic_desc"​ TEXT );


-- Create table for posts:
CREATE​ ​TABLE​ ​"posts"​(
"post_id"​ SERIAL PRIMARY ​KEY​,
"post_title"​ VARCHAR(​100​) ​NOT​ NULL ​CHECK​ (​LENGTH​(​TRIM​(​"post_title"​))>​0​),
"topic_id"​ INT ​REFERENCES​ "​topics"​(​"topic_id"​) ​ON​ ​DELETE​ C​ASCADE ​NOT​ NULL​,
"user_id"​ INT ​REFERENCES​ ​"users"​(​"user_id"​) ​ON​ ​DELETE​ S​ET​ NULL,
"url"​ VARCHAR(​2000​),
"text_content"​ TEXT,
CONSTRAINT​ url_text ​CHECK​(("​ url"​ ​IS​ NULL ​AND​ ​"text_content"​ I​S​ ​NOT​ NULL) ​OR
(​"url"​ ​IS​ ​NOT​ NULL ​AND​ ​"text_content"​ ​IS​ NULL)) );


-- Create index on topic_id in posts:
CREATE INDEX idx_posts_topic_id ON "posts" ("topic_id");


-- Create table for comments:
CREATE​ ​TABLE​ ​"comments"​(
"comment_id"​ SERIAL PRIMARY ​KEY​,
"parent_comment_id"​ INT ​REFERENCES​ ​"comments"​(​"comment_id"​) ​ON​ ​DELETE
CASCADE​,
"post_id"​ INT ​REFERENCES​ ​"posts"​(​"post_id"​) ​ON​ ​DELETE​ C​ASCADE ​NOT​ NULL​,
"user_id"​ INT ​REFERENCES​ ​"users"​(​"user_id"​) ​ON​ ​DELETE​ S​ET​ NULL,
"text"​ TEXT ​NOT​ NULL
);


-- Create index on post_id in comments:
CREATE INDEX idx_comments_post_id ON "comments" ("post_id");


-- Create table for votes:
CREATE​ ​TABLE​ ​"votes"​(
"vote_id"​ SERIAL PRIMARY ​KEY​,
"post_id"​ INT ​REFERENCES​ ​"posts"​(​"post_id"​) ​ON​ ​DELETE​ C​ASCADE ​NOT​ NULL​​,
"user_id"​ INT ​REFERENCES​ ​"users"​(​"user_id"​) ​ON​ ​DELETE​ S​ET​ NULL,
"vote"​ SMALLINT ​CHECK​("​vote"​ = ​1​ ​OR​ ​"vote"​ = ​-1​),
CONSTRAINT​ ​"user_vote"​ ​UNIQUE​ (​"user_id"​, ​"post_id"​)
);
