-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TYPE card_types AS ENUM ('letter');
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    current_game UUID DEFAULT NULL,
    prose_points INT DEFAULT 0 NOT NULL,
    assistance_points INT DEFAULT 0 NOT NULL,
    social_points INT DEFAULT 0 NOT NULL,
    prose_wins INT DEFAULT 0 NOT NULL,
    assistance_wins INT DEFAULT 0 NOT NULL,
    social_wins INT DEFAULT 0 NOT NULL
);
CREATE TABLE game_records (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    social_win_threshold INT NOT NULL,
    assistance_win_threshold INT NOT NULL,
    prose_win_threshold INT NOT NULL
);
CREATE TABLE cards (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    game_record_id UUID NOT NULL,
    user_id UUID NOT NULL,
    card_type card_types NOT NULL
);
CREATE TYPE event_types AS ENUM ('push');
CREATE TABLE events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    event_type event_types NOT NULL,
    game UUID DEFAULT uuid_generate_v4() NOT NULL
);
ALTER TABLE cards ADD CONSTRAINT cards_ref_game_record_id FOREIGN KEY (game_record_id) REFERENCES game_records (id) ON DELETE NO ACTION;
ALTER TABLE cards ADD CONSTRAINT cards_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE users ADD CONSTRAINT current_game FOREIGN KEY (current_game) REFERENCES game_records (id) ON DELETE NO ACTION;
ALTER TABLE events ADD CONSTRAINT game FOREIGN KEY (game) REFERENCES game_records (id) ON DELETE NO ACTION;
