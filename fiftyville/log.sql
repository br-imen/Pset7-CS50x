
-- search description from crime scene:
SELECT description FROM crime_scene_reports
WHERE year = 2021 and month ="7" and day = 28 and street = "Humphrey Street";

    --| Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
    --Interviews were conducted today with three witnesses who were present at the time
    -- – each of their interview transcripts mentions the bakery. |
    --| Littering took place at 16:36. No known witnesses.



-- search transcript of interview of 3 :  transcript mention the bakery:
SELECT name, transcript FROM interviews WHERE day = 28 and year = 2021;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

        --RAYMOND- As the thief was leaving the bakery,
        --they called someone who talked to them for less than a minute.
        --In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
        --The thief then asked the person on the other end of the phone to purchase the flight ticket.

        --RUTH-| Sometime within ten minutes of the theft,
        --I saw the thief get into a car in the bakery parking lot and drive away.
        -- If you have security footage from the bakery parking lot,
        --you might want to look for cars that left the parking lot in that time frame.

        --EUGINE--| I don't know the thief's name, but it was someone I recognized.
        -- Earlier this morning, before I arrive
        -- at Emma's bakery,
        --I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.



-- search the id of fiftyville airport and the earliest flight on 29 july 2021 out of fiftyville:
select id from airports where city ="Fiftyville";
        -- id is 4
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
select flights.id, destination_airport_id, minute,hour from flights
where origin_airport_id = 8 and year = 2021 and month = 7 and day = 29 order by hour limit 1;

        -- earliest flight on 29 july 2021 : 8:20 to destination id = 4 and flights id = 36

select city, full_name from airports where id = 4;

        -- destination id = 4 is  city = new york city and laGuardia Airport

-- search the atm_transactions:
select id, account_number, amount from atm_transactions
where day = 28 and month = 7 and year = 2021 and transaction_type = "withdraw"
and atm_location = "Leggett Street";


-- a list of names, phone_number, passeport_number and license from people
--who did the atm_transations that day 28 july 2021
select people.id, name, phone_number, passport_number, license_plate from people join bank_accounts on person_id = people.id
join atm_transactions on atm_transactions.account_number = bank_accounts.account_number
where atm_transactions. day = 28 and atm_transactions. month = 7 and atm_transactions.year = 2021
and atm_transactions.transaction_type = "withdraw"
and atm_transactions. atm_location = "Leggett Street";


-- searching the license cars from bakery security logs : time 28 7 2021 between 10:15 and 10:25

SELECT license_plate, activity, hour, minute from bakery_security_logs
where day = 28 and month = 7 and year = 2021 and
 hour = 10 and minute between '15' and '26' order by minute;

-- searching people who license cars matched from bakery security logs : time 28 7 2021 between 10:15 and 10:25
 select people.id, name, phone_number, passport_number, people.license_plate
 from people join bakery_security_logs on bakery_security_logs.license_plate = people.license_plate
 where bakery_security_logs.day = 28 and month = 7 and year = 2021 and hour = 10 and minute between '15' and '26';

 -- intersection of two who did transections atm and exit the bakery logs:

select people.id, name, phone_number, passport_number, license_plate from people
join bank_accounts on person_id = people.id
join atm_transactions on atm_transactions.account_number = bank_accounts.account_number
where atm_transactions. day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021
and atm_transactions.transaction_type = "withdraw"
and atm_transactions. atm_location = "Leggett Street"

INTERSECT

select people.id, name, phone_number, passport_number, people.license_plate from people
join bakery_security_logs on bakery_security_logs.license_plate = people.license_plate
where bakery_security_logs.day = 28 and month = 7 and year = 2021 and hour = 10 and
minute between '15' and '26';

-- 4 names of suspects thiefs: iman: 396669; luca: 467400, diana: 514354, bruce: 686048

-- search from that list who flight on new york from flights and
--passengers and who exit from bakery log and who did the transection atm:
select people.id, name, people.phone_number, people.passport_number, people.license_plate from people
join passengers on passengers.passport_number = people.passport_number
join flights on flights.id = passengers.flight_id
where flights.id = 36
and people.passport_number in
(select people.passport_number from people
join bank_accounts on person_id = people.id
join atm_transactions on atm_transactions.account_number = bank_accounts.account_number
where atm_transactions. day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021
and atm_transactions.transaction_type = "withdraw"
and atm_transactions. atm_location = "Leggett Street"

INTERSECT

select people.passport_number from people
join bakery_security_logs on bakery_security_logs.license_plate = people.license_plate
where bakery_security_logs.day = 28 and month = 7 and year = 2021 and hour = 10 and
minute between '15' and '26'
);

-- 2 suspects : bruce and luca

-- search callers : who calls that day less than 60seconds
select caller, receiver, duration from phone_calls
where day = 28 and month = 7 and year = 2021 and duration < 60;

-- matching the callers with the list of suspects:
select people.id, name, people.phone_number, people.passport_number, people.license_plate from people
join passengers on passengers.passport_number = people.passport_number
join flights on flights.id = passengers.flight_id
where flights.id = 36
and people.passport_number in
(select people.passport_number from people
join bank_accounts on person_id = people.id
join atm_transactions on atm_transactions.account_number = bank_accounts.account_number
where atm_transactions. day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021
and atm_transactions.transaction_type = "withdraw"
and atm_transactions. atm_location = "Leggett Street"

INTERSECT

select people.passport_number from people
join bakery_security_logs on bakery_security_logs.license_plate = people.license_plate
where bakery_security_logs.day = 28 and month = 7 and year = 2021 and hour = 10 and
minute between '15' and '26'
)

and people.phone_number in
(select phone_calls.caller from phone_calls
where phone_calls.day = 28 and phone_calls.month = 7
and phone_calls.year = 2021 and phone_calls.duration < 60);

-- bruce is the suspect, search for the receiver who is going to flight with him:
select * from people where people.phone_number = "(375) 555-8161";