create table user (
                      id INTEGER not null primary key autoincrement unique,
                      name TEXT not null,
                      email TEXT not null unique,
                      password TEXT not null,
                      userType TEXT not null,
                      location TEXT not null ,
                      gender text not null
);

create table product(
                        id INTEGER not null primary key autoincrement unique,
                        name TEXT not null,
                        long_term integer default 0 not null,
                        price integer not null
);

create table product_line(
                             id INTEGER not null primary key autoincrement unique,
                             line text not null,
                             product_id integer not null ,
                             foreign key (product_id) references product(id) on delete cascade
);

create table staff(
                      id INTEGER not null primary key autoincrement unique,
                      firstname text not null ,
                      lastname text not null ,
                      product_line_id integer not null ,
                      foreign key (product_line_id) references product_line(id) on update cascade
);

create table cart(
                     id INTEGER not null primary key autoincrement unique,
                     product_id integer not null references product_line on update cascade on delete cascade ,
                     user_id integer not null references user on delete cascade on update cascade ,
                     total integer not null ,
                     price integer not null,
                     created_at datetime default CURRENT_TIMESTAMP not null,
                     bought_at datetime
);

create table guests(
                       id INTEGER not null primary key autoincrement unique,
                       guestIdentifier text unique not null
);

create table likes(
                      id INTEGER not null primary key autoincrement unique,
                      product_id integer not null references product on delete cascade ,
                      customer_id integer references user,
                      guest_id references guests
);

insert into user ( name, email, password, userType, location, gender)
values  ( 'manager', 'manager@mukwano.com', 'manager', 'manager', 'kampala', 'female');