import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
import unittest
from unittest.mock import patch, MagicMock
from functions import OPR_to_ODS_SQL, OPR_to_ODS_MySQL, OPR_to_ODS_CSV,OPR_to_ODS_API,DWH
import pandas as pd

class TestOPRToODSSQL(unittest.TestCase):

    @patch('pyodbc.connect')
    def test_OPR_to_ODS_SQL_success(self, mock_connect):
        # Mock the SQL source connection
        mock_source_conn = MagicMock()
        # Mock the pandas read_sql method
        with patch('pandas.read_sql') as mock_read_sql:
            # Create a dummy DataFrame
            mock_df = pd.DataFrame({
                'col1': [1, 2],
                'col2': [3.0, None]
            })
            mock_read_sql.return_value = mock_df

            # Mock the target connection
            mock_target_conn = MagicMock()
            mock_cursor = MagicMock()
            mock_target_conn.cursor.return_value = mock_cursor

            # Example OPR_to_ODS_tables_list_SQL
            OPR_to_ODS_tables_list_SQL = {
                'test_table': 'SELECT * FROM test_table'
            }

            # Call the function
            success = OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL, mock_source_conn, mock_target_conn)

            # Print the calls to debug
            print("Execute calls:", mock_cursor.execute.call_args_list)

            # Assertions
            self.assertTrue(success)
            mock_cursor.execute.assert_called()  # Check if execute was called

            # Calculate expected number of calls: 1 for truncate + number of rows in the DataFrame for inserts
            expected_execute_calls = 1 + len(mock_df)
            self.assertEqual(mock_cursor.execute.call_count, expected_execute_calls)

            mock_target_conn.commit.assert_called_once()  # Ensure commit was called once

    @patch('pyodbc.connect')
    def test_OPR_to_ODS_SQL_failure(self, mock_connect):
        # Mock the SQL source connection
        mock_source_conn = MagicMock()
        # Mock the pandas read_sql method
        with patch('pandas.read_sql') as mock_read_sql:
            mock_read_sql.side_effect = Exception('Database error')

            # Mock the target connection
            mock_target_conn = MagicMock()
            mock_cursor = MagicMock()
            mock_target_conn.cursor.return_value = mock_cursor

            # Example OPR_to_ODS_tables_list_SQL
            OPR_to_ODS_tables_list_SQL = {
                'test_table': 'SELECT * FROM test_table'
            }

            # Call the function
            success = OPR_to_ODS_SQL(OPR_to_ODS_tables_list_SQL, mock_source_conn, mock_target_conn)

            # Print the calls to debug
            print("Execute calls:", mock_cursor.execute.call_args_list)

            # Assertions
            self.assertFalse(success)
            mock_cursor.execute.assert_called()  # Check if execute was called
            self.assertEqual(mock_cursor.execute.call_count, 1)  # Only truncate should be called before the error
            mock_target_conn.rollback.assert_called_once()  # Ensure rollback was called

class TestOPRToODSMysql(unittest.TestCase):

    @patch('mysql.connector.connect')
    @patch('pyodbc.connect')
    def test_OPR_to_ODS_MySQL_success(self, mock_target_connect, mock_mysql_connect):
        # Mock the MySQL source connection
        mock_mysql_source_con = MagicMock()
        # Mock the pandas read_sql method
        with patch('pandas.read_sql') as mock_read_sql:
            # Create a dummy DataFrame
            mock_df = pd.DataFrame({
                'col1': [1, 2],
                'col2': [3.0, None]
            })
            mock_read_sql.return_value = mock_df

            # Mock the target connection
            mock_target_conn = MagicMock()
            mock_cursor = MagicMock()
            mock_target_conn.cursor.return_value = mock_cursor

            # Example OPR_to_ODS_tables_list_MySQL
            OPR_to_ODS_tables_list_MySQL = {
                'test_table': 'SELECT * FROM test_table'
            }

            # Call the function
            success = OPR_to_ODS_MySQL(OPR_to_ODS_tables_list_MySQL, mock_mysql_source_con, mock_target_conn)

            # Print the calls to debug
            print("Execute calls:", mock_cursor.execute.call_args_list)

            # Assertions
            self.assertTrue(success)
            mock_cursor.execute.assert_called()  # Check if execute was called

            # Calculate expected number of calls: 1 for truncate + number of rows in the DataFrame for inserts
            expected_execute_calls = 1 + len(mock_df)
            self.assertEqual(mock_cursor.execute.call_count, expected_execute_calls)

            mock_target_conn.commit.assert_called_once()  # Ensure commit was called once

    @patch('mysql.connector.connect')
    @patch('pyodbc.connect')
    def test_OPR_to_ODS_MySQL_failure(self, mock_target_connect, mock_mysql_connect):
        # Mock the MySQL source connection
        mock_mysql_source_con = MagicMock()
        # Mock the pandas read_sql method
        with patch('pandas.read_sql') as mock_read_sql:
            mock_read_sql.side_effect = Exception('Database error')

            # Mock the target connection
            mock_target_conn = MagicMock()
            mock_cursor = MagicMock()
            mock_target_conn.cursor.return_value = mock_cursor

            # Example OPR_to_ODS_tables_list_MySQL
            OPR_to_ODS_tables_list_MySQL = {
                'test_table': 'SELECT * FROM test_table'
            }

            # Call the function
            success = OPR_to_ODS_MySQL(OPR_to_ODS_tables_list_MySQL, mock_mysql_source_con, mock_target_conn)

            # Print the calls to debug
            print("Execute calls:", mock_cursor.execute.call_args_list)

            # Assertions
            self.assertFalse(success)
            mock_cursor.execute.assert_called()  # Check if execute was called
            self.assertEqual(mock_cursor.execute.call_count, 1)  # Only truncate should be called before the error
            mock_target_conn.rollback.assert_called_once()  # Ensure rollback was called

class TestOPRToODSCsv(unittest.TestCase):

    @patch('pandas.read_csv')
    @patch('pyodbc.connect')
    def test_OPR_to_ODS_CSV_success(self, mock_connect, mock_read_csv):
        # Mock the CSV reading to return a dummy DataFrame
        mock_df = pd.DataFrame({
            'col1': [1, 2],
            'col2': [3.0, None]
        })
        mock_read_csv.return_value = mock_df

        # Mock the target connection
        mock_target_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_target_conn.cursor.return_value = mock_cursor

        # Example OPR_to_ODS_tables_list_CSV
        OPR_to_ODS_tables_list_CSV = {
            'test_table': 'path/to/test_table.csv'
        }

        # Call the function
        success = OPR_to_ODS_CSV(OPR_to_ODS_tables_list_CSV, mock_target_conn)

        # Print the calls to debug
        print("Execute calls:", mock_cursor.execute.call_args_list)

        # Assertions
        self.assertTrue(success)
        # Ensure that execute was called for both truncate and insert operations
        self.assertEqual(mock_cursor.execute.call_count, 3)  # 1 for truncate, 2 for rows in DataFrame
        mock_target_conn.commit.assert_called_once()  # Ensure commit was called once

class TestOPRToODSAPI(unittest.TestCase):
    
    @patch('requests.get')  # Mock the API request
    @patch('pyodbc.connect')  # Mock the database connection
    def test_OPR_to_ODS_API_processing_failure(self, mock_connect, mock_requests_get):
        # Mock the API response
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.json.return_value = [
            {'col1': 1, 'col2': 3.0},
            {'col1': 2, 'col2': None}
        ]
        mock_requests_get.return_value = mock_response

        # Mock the target connection
        mock_target_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_target_conn.cursor.return_value = mock_cursor
        mock_cursor.execute.side_effect = Exception('Database error during insert')

        # Example OPR_to_ODS_tables_list_API
        OPR_to_ODS_tables_list_API = {
            'test_table': 'http://api.example.com/data'
        }

        # Call the function
        success = OPR_to_ODS_API(OPR_to_ODS_tables_list_API, mock_target_conn)

        # Print the calls to debug
        print("Execute calls:", mock_cursor.execute.call_args_list)
        print("Rollback calls:", mock_target_conn.rollback.call_args_list)

        # Assertions
        self.assertFalse(success)
        mock_cursor.execute.assert_called()  # Check if execute was called
        self.assertEqual(mock_cursor.execute.call_count, 1)  # Only the truncate should be called before the error
        mock_target_conn.rollback.assert_called_once()  # Ensure rollback was called

if __name__ == '__main__':
    unittest.main()
