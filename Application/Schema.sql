-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TYPE card_type AS ENUM ('letter');
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    current_game UUID DEFAULT NULL
);
CREATE TABLE game_records (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    winning_user UUID DEFAULT NULL,
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT NULL
);
CREATE TABLE cards (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    game_record_id UUID NOT NULL,
    user_id UUID NOT NULL,
    card_type card_type NOT NULL
);
ALTER TABLE cards ADD CONSTRAINT cards_ref_game_record_id FOREIGN KEY (game_record_id) REFERENCES game_records (id) ON DELETE NO ACTION;
ALTER TABLE cards ADD CONSTRAINT cards_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE users ADD CONSTRAINT current_game FOREIGN KEY (current_game) REFERENCES game_records (id) ON DELETE NO ACTION;
ALTER TABLE game_records ADD CONSTRAINT winning_user FOREIGN KEY (winning_user) REFERENCES users (id) ON DELETE NO ACTION;
