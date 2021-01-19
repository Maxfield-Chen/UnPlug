-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TYPE bot_cards AS ENUM ();
CREATE TYPE nature_cards AS ENUM ();
CREATE TYPE piece_types AS ENUM ('nature_frog', 'nature_snake', 'nature_crawdad', 'nature_squid', 'bot_factory', 'bot_gray_goo', 'bot_bomb', 'bot_servitor');
CREATE TYPE piece_actions AS ENUM ('move');
CREATE TYPE piece_statuses AS ENUM ('alive');
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE TABLE pieces (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    piece_type piece_types NOT NULL,
    X INT NOT NULL,
    Y INT NOT NULL,
    game_record_id UUID NOT NULL,
    user_id UUID NOT NULL,
    status piece_statuses NOT NULL
);
CREATE TABLE game_records (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    bot_user UUID NOT NULL,
    nature_user UUID NOT NULL,
    winning_user UUID DEFAULT NULL,
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    bot_user_action_points INT DEFAULT 0 NOT NULL,
    nature_user_action_points INT DEFAULT 0 NOT NULL
);
CREATE TABLE cards (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    game_record_id UUID NOT NULL,
    user_id UUID NOT NULL
);
ALTER TABLE game_records ADD CONSTRAINT bot_user FOREIGN KEY (bot_user) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE cards ADD CONSTRAINT cards_ref_game_record_id FOREIGN KEY (game_record_id) REFERENCES game_records (id) ON DELETE NO ACTION;
ALTER TABLE cards ADD CONSTRAINT cards_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE game_records ADD CONSTRAINT nature_user FOREIGN KEY (nature_user) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE pieces ADD CONSTRAINT pieces_ref_game_record_id FOREIGN KEY (game_record_id) REFERENCES game_records (id) ON DELETE NO ACTION;
ALTER TABLE pieces ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE game_records ADD CONSTRAINT winning_user FOREIGN KEY (winning_user) REFERENCES users (id) ON DELETE NO ACTION;
